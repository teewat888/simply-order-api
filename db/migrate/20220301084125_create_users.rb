class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :company_name
      t.string :address_number
      t.string :address_street
      t.string :address_suburb
      t.string :address_state
      t.string :contact_number
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
