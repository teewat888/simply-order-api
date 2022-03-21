class Api::V1::OrderTemplatesController < ApplicationController
    before_action :authorized, only: [:index, :create, :destroy ]

    def index
        if (params[:user_id] && params[:vendor_id])
            render json: { success: true, templates: OrderTemplate.order_template_list(user: params[:user_id],vendor: params[:vendor_id])}
        elsif (params[:user_id])
            render json: { success: true, templates: OrderTemplate.own_order_template_list(user: params[:user_id])}
        end

    end

    def create
        order_templates = OrderTemplate.new(order_templates_params)
        if order_templates.save
            render json: { success: true, message:"Order template created"}
        else
            render json: { success: false, message: "Error while creating a template."}
        end
    end

    #have to add authorized here once finish test
    def order_form
        if(params[:template_id] && params[:vendor_id] && params[:user_id])
            #template name
            template_name = OrderTemplate.find(params[:template_id]).name
            #get products
            products = Product.available_products_for_order_form(template_id: params[:template_id])
            #create order
            order = Order.new(user_id: params[:user_id], vendor_id: params[:vendor_id], order_details: products)
            #init values
            order.order_ref = "#{template_name} #{order_time}"
            order.order_date = Time.now
            if order.save
                render json: { success: true, id: order.id, order_date: order.order_date, delivery_date: "", comment: "", order_ref: order.order_ref, user_id: params[:user_id], vendor_id: params[:vendor_id], order_details: order.order_details}
            else
                render json: { success: false, message: "Error while creating order."}
            end
            #render json: { success: true, products: Product.available_products_for_order_form(template_id: params[:template_id]) }
        else
            render json: { success: false, message: "Error while creating order with this template.(Incompleted/incorrect params"}
        end
    end


    private

    def order_templates_params
        #  products: [:id, :name,:brand,:unit,:in_template, :qty] will identify what will include in jsonb - products
        params.require(:order_template).permit(:user_id,:vendor_id,:name, products: [:id, :name,:brand,:unit,:in_template, :qty])
    end

    def order_time
        t = Time.now
        t.strftime("(%d/%m/%Y)")
    end

end