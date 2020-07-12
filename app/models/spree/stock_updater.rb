module Spree
  class StockUpdater < Spree::Base
    has_attached_file :data_file
    validates_attachment :data_file, content_type: { content_type: ["text/csv", "text/plain"] }
  end
end
