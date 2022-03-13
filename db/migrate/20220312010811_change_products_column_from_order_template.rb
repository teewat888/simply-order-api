class ChangeProductsColumnFromOrderTemplate < ActiveRecord::Migration[6.1]
  def change
    change_column :order_templates, :products, 'json USING CAST(products AS json)'
  end
  
end
