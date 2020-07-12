require 'spec_helper'

describe Spree::StockUpdater, type: :model do

  it { should have_attached_file(:data_file) }
  it { should validate_attachment_content_type(:data_file).
                allowing('text/csv', 'text/plain').
                rejecting('image/gif', 'text/xml') }
end
