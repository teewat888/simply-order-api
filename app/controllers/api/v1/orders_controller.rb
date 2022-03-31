class Api::V1::OrdersController < ApplicationController
    before_action :authorized
    before_action :set_order, only: [:show, :edit, :update, :destroy, :send_mail]
    before_action :qty_not_zero, only: [:send_mail]
  

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
    #get orders to the vendor
    # def vendor_orders 
    #     orders = Order.where("vendor_id = ?",params[:id])
    #     if orders
    #         orders_res = []
    #         orders.each do |order| 
    #             new_orders = {
    #                 id: order.id,
    #                 order_date: order.order_date,
    #                 delivery_date: order.delivery_date,
    #                 comment: order.comment,
    #                 customer: order.user.company_name,
    #                 order_details: filter_qty(order.order_details)
    #             }
    #             orders_res << new_orders
    #         end
    #         render json: {success: true, orders: orders_res, message: "successfully load orders"}
    #     else
    #         render json: {success: false, message: "Error while loading orders"}
    #     end
    # end

    def send_mail
        customer = User.find(@order.user_id) #find the customer company to make in the subject & body of email
        OrderMailer.with(order: @order, customer: customer).send_order_email.deliver_now
        render json: {success: true, message: "sent email"}
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
        @order =  Order.find(params[:id])
    end

    def order_params
        params.require(:order).permit(:id, :comment, :order_date, :delivery_date, :user_id, :vendor_id, :order_ref,:email_to, order_details: [:id, :name,:brand,:unit, :qty, :in_template])
    end

    def qty_not_zero
        @order.email_details = @order.order_details.select do |detail| 
            detail['qty'] != "0" && detail['qty'] != ""
        end
    end

    def filter_qty(order)
        order.select {|detail| detail['qty'] != "0"}
    end

end