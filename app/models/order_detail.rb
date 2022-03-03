# == Schema Information
#
# Table name: order_details
#
#  id         :bigint           not null, primary key
#  note       :string
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint
#  product_id :bigint
#
class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :product 
end
