class AddOrderDetailsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_details, :jsonb 
  end
end
