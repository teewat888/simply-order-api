class DropOrderDetail < ActiveRecord::Migration[6.1]
  def up
    drop_table :order_details
  end

  def change
  end

  def down 
    fail ActiveRecord::IrreversibleMigration
  end
end
