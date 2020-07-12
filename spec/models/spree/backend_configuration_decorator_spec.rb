require 'spec_helper'

describe Spree::BackendConfiguration, type: :model do

  describe 'Stock Items constant' do
    it { expect(Spree::BackendConfiguration::STOCKS_TABS).to eq([:stock_items]) }
  end
end
