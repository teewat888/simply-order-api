class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.bigint :order_id
      t.bigint :product_id
      t.integer :quantity
      t.string :note

      t.timestamps
    end
  end
end
