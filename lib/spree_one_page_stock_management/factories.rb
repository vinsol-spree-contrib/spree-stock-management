FactoryBot.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_one_page_stock_management/factories'
  factory :stock_updater, class: Spree::StockUpdater do
    data_file { File.new(Rails.root + 'lib/test.csv') }
  end

  factory :stock_updater_with_fault_variant, class: Spree::StockUpdater do
    data_file { File.new(Rails.root + 'lib/fault_variant.csv') }
  end

  factory :stock_updater_with_fault_stock_location, class: Spree::StockUpdater do
    data_file { File.new(Rails.root + 'lib/fault_stock_location.csv') }
  end

end
