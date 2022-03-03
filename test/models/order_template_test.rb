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
require "test_helper"

class OrderTemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
