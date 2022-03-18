class ChangeDeliveryDateColumnTypeInOrder < ActiveRecord::Migration[6.1]
  def change
     change_column :orders, :delivery_date, 'date USING CAST(delivery_date AS date)'
  end
end
