require 'spec_helper'

describe NotifyFailedStocksService do
  let!(:stock_updater) { FactoryBot.create(:stock_updater) }
  let!(:variant) { FactoryBot.create(:variant) }
  let!(:stock_location) { FactoryBot.create(:stock_location) }
  let(:service) { NotifyFailedStocksService.new(stock_updater.id, 'test@gmail.com') }

  describe 'initialize' do
    it "is expected to set an stock updater intance variable" do
      expect(service.instance_variable_get(:@stock_updater).class).to eq(Spree::StockUpdater)
    end

    it 'sets the job executed field to true' do
      expect(service.instance_variable_get(:@stock_updater).job_executed?).to eq(true)
    end

    it 'sends the mail to the admin emails' do
      expect { NotifyFailedStocksService.new(stock_updater.id, 'test@gmail.com') }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "expecs to destroy the stock updater data file" do
      expect(service.instance_variable_get(:@stock_updater).data_file.path).to eq(nil)
    end
  end


  describe 'find_variant_and_stock_location' do

    context "when called for test csv" do
      it "is expected to set an variant instance variable" do
        expect(service.instance_variable_get(:@variant).class).to eq(Spree::Variant)
      end

      it "is expected to set an stock location instance variable" do
        expect(service.instance_variable_get(:@stock_location).class).to eq(Spree::StockLocation)
      end
    end

    context "when called with wrong arguments" do
      before do
        service.instance_variable_get(:@row)['uid'] = 'abcd'
        service.instance_variable_get(:@row)['stock_location_name'] = 'not found'
        service.send :find_variant_and_stock_location
      end

      it "is expected to set an variant instance variable to nil" do
        expect(service.instance_variable_get(:@variant).class).to eq(NilClass)
      end

      it "is expected to set an stock location instance variable" do
        expect(service.instance_variable_get(:@stock_location).class).to eq(NilClass)
      end
    end
  end

  describe 'set_backorderable' do
    context "for test csv" do
      it "expects to assign backorderable instance variable to false" do
        expect(service.instance_variable_get(:@backorderable)).to eq(false)
      end
    end

    context "when called with true argument" do
      before { service.send(:set_backorderable, 'true') }
      it 'expects to assign backorderable instance variable to true' do
        expect(service.instance_variable_get(:@backorderable)).to eq(true)
      end
    end

    context "when called with any argument other than true or false" do
      before { service.send(:set_backorderable, 'abcd') }
      it 'expects to assign backorderable instance variable to stock item backorderable value' do
        expect(service.instance_variable_get(:@backorderable)).to eq(service.instance_variable_get(:@stock_item).backorderable)
      end
    end
  end

  describe 'set_count_on_hand' do
    context "for test csv" do
      it "expects to assign count_on_hand instance variable to 20" do
        expect(service.instance_variable_get(:@count_on_hand)).to eq("20")
      end
    end

    context "when called with value other than integer" do
      before do
        service.instance_variable_get(:@row)['count_on_hand'] = 'abcd'
        service.send :set_count_on_hand
      end

      it 'expect to assign count_on_hand instance variable to stock item count_on_hand value' do
        expect(service.instance_variable_get(:@count_on_hand)).to eq(service.instance_variable_get(:@stock_item).count_on_hand)
      end
    end
  end

  describe 'update_stock_item' do
    it 'updates the count_on_hand of stock item' do
      expect(service.instance_variable_get(:@stock_item).count_on_hand).to eq(service.instance_variable_get(:@count_on_hand).to_i)
    end

    it 'updates the backorderable of stock item' do
      expect(service.instance_variable_get(:@stock_item).backorderable).to eq(service.instance_variable_get(:@backorderable))
    end
  end

  describe 'error_message' do
    context "when error is not present" do
      it { expect(service.send :error_message).to eq('Successfully Updated') }
    end

    context "when error is present" do
      before { service.instance_variable_set(:@error, 'Some error') }
      it { expect(service.send :error_message).to eq('Some error') }
    end
  end


  describe 'update_stocks' do
    it "is expected to set a csv row instance variable" do
      expect(service.instance_variable_get(:@row).class).to eq(CSV::Row)
    end

    it "is expected to set a stock item instance variable" do
      expect(service.instance_variable_get(:@stock_item).class).to eq(Spree::StockItem)
    end

    context "when variant instance variable is nil" do
      let(:stock_updater_with_fault_variant) { FactoryBot.create(:stock_updater_with_fault_variant) }
      let(:service_with_fault_variant) { NotifyFailedStocksService.new(stock_updater_with_fault_variant.id, 'test@gmail.com') }

      it 'is expected to set error message' do
        expect(service_with_fault_variant.instance_variable_get(:@error)).to eq('Product not found')
      end
    end

    context "when stock location instance variable is nil" do
      let(:stock_updater_with_fault_stock_location) { FactoryBot.create(:stock_updater_with_fault_stock_location) }
      let(:service_with_fault_stock_location) { NotifyFailedStocksService.new(stock_updater_with_fault_stock_location.id, 'test@gmail.com') }

      it 'is expected to set error message' do
        expect(service_with_fault_stock_location.instance_variable_get(:@error)).to eq('Stock Location Not found')
      end
    end

    context "when stock item instance variable is nil" do
      before { Spree::StockItem.all.map(&:destroy) }
      let(:service_with_fault_stock_item) { NotifyFailedStocksService.new(stock_updater.id, 'test@gmail.com') }

      it 'is expected to set error message' do
        expect(service_with_fault_stock_item.instance_variable_get(:@error)).to eq('Stock Item not found')
      end
    end
  end

end
