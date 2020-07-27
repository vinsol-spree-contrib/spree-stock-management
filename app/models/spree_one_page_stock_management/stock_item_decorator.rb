module SpreeOnePageStockManagement::StockItemDecorator

  def self.prepended(base)
    base.whitelisted_ransackable_associations = ['variant']
    base.whitelisted_ransackable_scopes = %i(variant_product_name_cont search_variant_product_name)
  end

  def variant_product_name_cont(query)
    joins(variant: :product).where("#{Product.table_name}.name LIKE :query", query: "%#{query}%")
  end
end

::Spree::StockItem.prepend SpreeOnePageStockManagement::StockItemDecorator
