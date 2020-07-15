Deface::Override.new(
  virtual_path: 'spree/admin/shared/_main_menu',
  name: 'add_stock_item_tab',
  insert_bottom: "nav",
  text: %q{
      <% if can? :admin, Spree::StockItem %>
        <ul class="nav nav-sidebar border-bottom">
          <%= tab *Spree::BackendConfiguration::STOCKS_TABS, icon: 'th-list' %>
        </ul>
      <% end %>
    }
)
