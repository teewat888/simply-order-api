class AddEmailToColumnToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :email_to, :string
  end
end
