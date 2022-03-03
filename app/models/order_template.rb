# == Schema Information
#
# Table name: order_templates
#
#  id         :bigint           not null, primary key
#  products   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  vendor_id  :bigint
#
class OrderTemplate < ApplicationRecord
    belongs_to :user
    belongs_to :vendor, class_name: "User"
end
