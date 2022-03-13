class AddNameToOrderTemplate < ActiveRecord::Migration[6.1]
  def change
    add_column :order_templates, :name, :string
  end
end
