require 'spec_helper'

describe Spree::AppConfiguration, type: :model do
  describe 'per_page preferences' do
    it { expect(SpreeOnePageStockManagement::Config.stock_items_per_page).to eq(15) }
  end
end
