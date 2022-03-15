# == Schema Information
#
# Table name: orders
#
#  id            :bigint           not null, primary key
#  comment       :text
#  delivery_date :string
#  order_date    :date
#  order_ref     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#  vendor_id     :bigint
#
class Order < ApplicationRecord
    has_many :order_details
    has_many :products, through: :order_details
    belongs_to :user
    belongs_to :vendor, class_name: "User"

    #products that enable in template
    def self.products_in_template(template:)
        OrderTemplate.find(template).products.select { |p| p['in_template'] = true }
    end
end
