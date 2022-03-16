# == Schema Information
#
# Table name: order_templates
#
#  id         :bigint           not null, primary key
#  name       :string
#  products   :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  vendor_id  :bigint
#
class OrderTemplate < ApplicationRecord
    belongs_to :user
    belongs_to :vendor, class_name: "User"

    #templates of vendor
    def self.order_template_list(user: ,vendor: )
        User.find(user).order_templates.select('id, name, vendor_id').where(vendor_id: vendor)
    end
    #templates own by a user
    def self.own_order_template_list(user:)
        User.find(user).order_templates.select('id, name, vendor_id')
    end

    
end
