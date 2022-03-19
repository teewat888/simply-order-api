class Api::V1::OrdersController < ApplicationController

   def index
        if (params[:user_id])
            render json: {success: true, orders: User.find(params[:user_id]).orders}
        else
            render json: {success: false, message: "No order history."}
        end
   end

    private
    def order_params
        params.require(:order).permit(:id, :comment, :order_date, :delivery_date, :user_id, :vendor_id, :order_ref, order_details: [:id, :name,:brand,:unit, :qty])
    end
end