class CreateOrderTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :order_templates do |t|
      t.text :products

      t.timestamps
    end
  end
end
