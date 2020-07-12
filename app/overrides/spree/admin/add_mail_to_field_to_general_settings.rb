Deface::Override.new(
  virtual_path: 'spree/admin/general_settings/edit',
  name: 'add_mail_to_field_to_general_settings',
  insert_before: "div.row:eq(4)",
  text: %q{
      <div class="row">
        <div class="col-xs-12 col-md-6">
          <div class="form-group" data-hook="admin_general_setting_mail_to_address">
            <%= label_tag :mail_to_address %>
            <%= text_field_tag :mail_to_address, Spree::Config[:mail_to_address], placeholder: Spree.t('mail_to_address'), class: 'form-control'  %>
          </div>
        </div>
      </div>
    }
)
