class ChangeProductsTypeToJsonb < ActiveRecord::Migration[6.1]
  def change
    change_column :order_templates, :products, 'jsonb USING CAST(products AS jsonb)'
  end
end
