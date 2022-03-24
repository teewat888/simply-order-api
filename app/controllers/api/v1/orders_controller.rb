class Api::V1::OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]

    def index
        if (params[:user_id]) 
            render json: {success: true, orders: User.find(params[:user_id]).orders.select('id, order_ref').order("updated_at DESC")}
        else
            render json: {success: false, message: "Error finding orders."}
        end
    end

    def show
        @order.order_details = @order.order_details.select {|detail| detail["qty"] != "0"}
        if @order
            render json: {success: true, order: @order} 
        else
            render json: {success: false, message: "Error obtaing order details"}
        end
    end

    def edit
        if @order
            render json: {success: true, order: @order} 
        else
            render json: {success: false, message: "Error obtaing order details"}
        end
    end
    
    def update
        if (@order.update(order_params))
            render json: {success: true, order: @order} 
        else
            render json: {success: false, message: "Error updating order"}
        end
    end

    def destroy
        if @order.destroy
            render json: {success: true, message: "Successfully delete order."} 
        else
            render json: {success: false, message: "Error deleting order"}
        end
    end

    private
    def set_order
        @order = order = Order.find(params[:id])
    end

    def order_params
        params.require(:order).permit(:id, :comment, :order_date, :delivery_date, :user_id, :vendor_id, :order_ref, order_details: [:id, :name,:brand,:unit, :qty, :in_template])
    end

end