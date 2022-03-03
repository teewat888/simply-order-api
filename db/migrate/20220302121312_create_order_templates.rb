class CreateOrderTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :order_templates do |t|
      t.text :products
      t.bigint :vendor_id
      t.bigint :user_id
      t.timestamps
    end
  end
end
