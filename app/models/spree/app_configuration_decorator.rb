Spree::AppConfiguration.class_eval do
  preference :stock_items_per_page, :integer, default: 15
  preference :mail_to_address, :string, default: 'spree@example.com'
end
