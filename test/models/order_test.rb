# == Schema Information
#
# Table name: orders
#
#  id            :bigint           not null, primary key
#  comment       :text
#  delivery_date :string
#  order_date    :date
#  order_details :jsonb
#  order_ref     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#  vendor_id     :bigint
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
