class OrderDetail < ApplicationRecord
    belongs_to :order
    belong_to :product 
end
