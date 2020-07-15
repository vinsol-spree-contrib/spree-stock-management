module Spree
  class SpreeOnePageStockManagementSetting < Preferences::Configuration
    preference :stock_items_per_page, :integer, default: 15
  end
end