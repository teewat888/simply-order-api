class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :unit,:available, :vendor
  belongs_to :vendor, serializer: VendorSerializer
end
