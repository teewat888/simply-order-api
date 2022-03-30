# == Schema Information
#
# Table name: orders
#
#  id            :bigint           not null, primary key
#  comment       :text
#  delivery_date :date
#  email_to      :string
#  order_date    :date
#  order_details :jsonb
#  order_ref     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#  vendor_id     :bigint
#
class Order < ApplicationRecord
    #to store only order qty emails
    attribute :email_details, :jsonb, default: {} 
   
    belongs_to :user
    belongs_to :vendor, class_name: "User"

    validates :delivery_date, presence: :true

    #products that enable in template
    def self.products_in_template(template:)
        OrderTemplate.find(template).products.select { |p| p['in_template'] = true }
    end
end
