class Product < ApplicationRecord
    belongs_to :vendor, class_name: "User"
    has_many :order_details
    has_many :orders, through: :order_details
end
