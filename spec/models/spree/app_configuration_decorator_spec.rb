require 'spec_helper'

describe Spree::AppConfiguration, type: :model do
  describe 'preferences' do
    it { expect(Spree::Config.stock_items_per_page).to eq(15) }
    it { expect(Spree::Config.mail_to_address).to eq('spree@example.com') }
  end
end
