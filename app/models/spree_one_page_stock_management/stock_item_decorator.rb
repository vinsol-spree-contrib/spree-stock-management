module SpreeOnePageStockManagement::StockItemDecorator

  def self.prepended(base)
    base.whitelisted_ransackable_associations = ['variant']
  end

end

Spree::StockItem.prepend SpreeOnePageStockManagement::StockItemDecorator