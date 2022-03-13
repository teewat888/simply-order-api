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
class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :unit, :available, :vendor, :in_template
  belongs_to :vendor, serializer: VendorSerializer
end
