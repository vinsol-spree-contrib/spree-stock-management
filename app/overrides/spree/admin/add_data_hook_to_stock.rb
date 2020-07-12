Deface::Override.new(
  virtual_path: 'spree/admin/products/stock',
  name: 'add_data_hook_to_stock',
  set_attributes: 'div.panel-default',
  attributes: { "data-hook": 'admin_stock_inventory_management' }
)
