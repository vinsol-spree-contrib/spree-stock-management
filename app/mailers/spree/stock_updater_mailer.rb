module Spree
  class StockUpdaterMailer < BaseMailer
    def update_admin(status_csv, admin_email, filename, total_records, successfull_records)
      @total_records = total_records
      @failed_records = total_records - successfull_records
      attachments['stock_items.csv'] = status_csv
      subject = "#{Spree::Store.current.name} import of #{ filename } has finished"
      mail(to: admin_email_notify_address, cc: admin_email, from: from_address, subject: subject)
    end

    private
      def admin_email_notify_address
        Spree::Config[:mail_to_address] || from_address
      end
  end
end
