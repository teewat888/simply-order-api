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
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
