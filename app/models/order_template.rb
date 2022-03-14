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

    def self.order_template_list(user: ,vendor: )
        User.find(user).order_templates.select('id, name').where(vendor_id: vendor)
    end

    def self.own_order_template_list(user:)
        User.find(user).order_templates.select('id, name')
    end
end
