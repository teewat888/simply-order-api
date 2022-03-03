class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :unit, :vendor
  belongs_to :vendor, serializer: VendorSerializer
end
