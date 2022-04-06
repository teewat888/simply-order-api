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
   #virtual attr for qty of order form
   attribute :qty, :string, default: '0' 
   #virtual attr for note of each product (will inplement for future release)
   attribute :note 

    belongs_to :vendor, class_name: "User"
    

    validates :name, presence: true
    validates :unit, presence: true

    def self.available_products_for_template(user:)
        products = User.find(user).products.select('id','name','brand','unit').where("available = true")
    end

    #check before create order form that product still available & also filter on that in the template
    def self.available_products_for_order_form(template_id:)
        products = OrderTemplate.find(template_id).products.select { |p| p['in_template'] == true }
        products.select do |product|
            result = Product.find(product['id']).available
        end
    end
end
