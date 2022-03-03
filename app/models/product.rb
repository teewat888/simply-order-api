# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  brand      :string
#  name       :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  vendor_id  :bigint
#
class Product < ApplicationRecord
    belongs_to :vendor, class_name: "User"
    has_many :order_details
    has_many :orders, through: :order_details
end
