module Spree
  class StockMovementReason < Spree::Base
    acts_as_paranoid

    has_one :spree_stock_movement_reason

    scope :only_enable, -> { where("enabled = true") }
  end
end