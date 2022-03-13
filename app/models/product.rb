# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  available  :boolean          default(TRUE)
#  brand      :string
#  name       :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  vendor_id  :bigint
#
class Product < ApplicationRecord
    #virtual attr to store the order template flag
   attribute :in_template, :boolean, default: true

    belongs_to :vendor, class_name: "User"
    has_many :order_details
    has_many :orders, through: :order_details

    validates :name, presence: true
    validates :unit, presence: true

    def self.available_products_for_template(user_id)
        products = User.find(user_id).products.select('id','name','brand','unit').where("available = true")
    end


end
