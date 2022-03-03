class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.date :order_date
      t.string :delivery_date
      t.text :comment
      t.string :order_ref
      t.bigint :vendor_id
      t.bigint :user_id
      t.timestamps
    end
  end
end
