class OrderTemplate < ApplicationRecord
    belongs_to :user
    belongs_to :vendor, class_name: "User"
end
