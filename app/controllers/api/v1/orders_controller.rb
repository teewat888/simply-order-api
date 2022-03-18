class Api::V1::OrdersController < ApplicationController

    def create
        order = Order.new(order_params)
        if order.save
            render json: { success: true, message: 'Successfully created order' }
        else
            render json: { success: false, message: 'Error creating an order.' }
        end
    end

    private
    def order_params
        params.require(:order).permit(:id, :comment, :order_date, :delivery_date, :user_id, :vendor_id, :order_ref, order_details: [:id, :name,:brand,:unit, :qty])
    end
end