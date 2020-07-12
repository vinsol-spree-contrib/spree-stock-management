require 'csv'

class NotifyFailedStocksService

  CSV_HEADERS = { 'Uid': :uid, 'Stock Location Name': :stock_location_name, 'Count on Hand': :count_on_hand, 'Backorderable': :backorderable, 'Status': :status }

  def initialize(stock_updater_id, admin_email)
    @stock_updater = Spree::StockUpdater.find_by(id: stock_updater_id)
    update_stocks
    @stock_updater.update_column(:job_executed, true)
    Spree::StockUpdaterMailer.update_admin(@csv_export, admin_email, @stock_updater.data_file_file_name, @total_records, @successfull_records).deliver_now
    @stock_updater.destroy if @stock_updater.job_executed?
  end

  private
    def update_stocks
      @total_records = 0
      @successfull_records = 0
      @csv_export = CSV.generate do |csv|
        unless csv_empty?
          csv << CSV_HEADERS.keys
          CSV.foreach(@stock_updater.data_file.path, headers: true) do |row|
            @error = nil
            @total_records += 1
            @row = row
            find_variant_and_stock_location
            if @variant && @stock_location
              @stock_item = Spree::StockItem.find_by(variant_id: @variant.id, stock_location_id: @stock_location.id)
              update_stocks_with_csv_values
            else
              @error = @variant ? Spree.t(:stock_location_not_found) : Spree.t(:product_not_found)
            end
            csv << set_row
          end
        end
      end
    end

    def csv_empty?
      CSV.readlines(@stock_updater.data_file.path) == [[]]
    end

    def set_row
      row = []
      CSV_HEADERS.each do |key, value|
        row << create_csv_row(key, value)
      end
      row
    end

    def create_csv_row(key, value)
      ( key == :Status ) ? error_message : @row[value.to_s]
    end

    def error_message
      @error ? @error : 'Successfully Updated'
    end

    def update_stocks_with_csv_values
      if @stock_item
        set_backorderable(@row['backorderable'].to_s.downcase)
        set_count_on_hand
        update_stock_item
        @successfull_records += 1
      else
        @error = Spree.t(:stock_item_not_found)
      end
    end

    def find_variant_and_stock_location
      @variant = Spree::Variant.find_by_sku(@row['uid'].to_s.upcase) || Spree::Variant.find_by_id(@row['uid'].to_i)
      @stock_location = Spree::StockLocation.find_by_name(@row['stock_location_name'])
    end

    def set_backorderable(csv_backorderable)
      if csv_backorderable == 'true'
        @backorderable = true
      elsif csv_backorderable == 'false'
        @backorderable = false
      else
        @backorderable = @stock_item.backorderable
      end
    end

    def set_count_on_hand
      @count_on_hand = ( @row['count_on_hand'] && @row['count_on_hand'].scan(/\D/).empty? ) ? @row['count_on_hand'] : @stock_item.count_on_hand
    end

    def update_stock_item
      @stock_item.update_columns(count_on_hand: @count_on_hand, backorderable: @backorderable)
    end
end
