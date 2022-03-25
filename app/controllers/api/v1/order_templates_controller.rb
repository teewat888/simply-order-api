class Api::V1::OrderTemplatesController < ApplicationController
    before_action :authorized, only: [:index, :create, :destroy ]

    def index
        if (params[:user_id] && params[:vendor_id])
            render json: { success: true, templates: OrderTemplate.order_template_list(user: params[:user_id],vendor: params[:vendor_id])}
        elsif (params[:user_id])
            render json: { success: true, templates: OrderTemplate.own_order_template_list(user: params[:user_id])}
        end

    end
    #/api/v1/users/:user_id/order_templates(.:format)  POST
    def create
        order_template = OrderTemplate.new(order_templates_params)
        if order_template.save
            render json: { success: true, message:"Order template created"}
        else
            render json: { success: false, message: "Error while creating a template."}
        end
    end
    # to get template details
    #/api/v1/users/:user_id/order_templates/:id/edit(.:format) GET
    def edit
        order_template = OrderTemplate.find(params[:id])
        if order_template
            render json: {success: true, message: "Ready to edit.", template_details: order_template}
        else
            render json:{success: false, message: "Error while loading template!"}
        end
    end
    #/api/v1/users/:user_id/order_templates/:id(.:format)
    def update
        order_template = OrderTemplate.find(params[:id])
        if order_template.update(order_templates_params)
            render json: {success: true, message: "Template edit successfully!"}
        else
            render json: {success: false, message: "Error while editing, please try again later."}
        end
    end
    #to get order items from template & create order 
    #have to add authorized here once finish test
    #/user/order_form?template_id=${templateId}&user_id=${userId}&vendor_id=${vendorId}  GET
    def order_form
        if(params[:template_id] && params[:vendor_id] && params[:user_id])
            #template name
            template_name = OrderTemplate.find(params[:template_id]).name
            #get products
            products = Product.available_products_for_order_form(template_id: params[:template_id])
            #create order
            order = Order.new(user_id: params[:user_id], vendor_id: params[:vendor_id], order_details: products)
            #init values
            order.order_ref = "#{template_name}-#{order_ref_number} #{order_time}"
            order.order_date = Time.now
            if order.save
                render json: { success: true, id: order.id, order_date: order.order_date, delivery_date: "", comment: "", order_ref: order.order_ref, user_id: params[:user_id], vendor_id: params[:vendor_id], order_details: order.order_details, message: "Order successfully created."}
            else
                render json: { success: false, message: "Error while creating order."}
            end
            #render json: { success: true, products: Product.available_products_for_order_form(template_id: params[:template_id]) }
        else
            render json: { success: false, message: "Error while creating order with this template.(Incompleted/incorrect params"}
        end
    end

    def destroy
        order_template = OrderTemplate.find(params[:id])
        if order_template.destroy
            render json: {success: true, message: "Template successfully deleted."}
        else
            render json: {success: false, message: "Sorry can not delete the template."}
        end
    end


    private

    def order_templates_params
        #  products: [:id, :name,:brand,:unit,:in_template, :qty] will identify what will include in jsonb - products
        params.require(:order_template).permit(:id, :user_id,:vendor_id,:name, products: [:id, :name,:brand,:unit,:in_template, :qty])
    end

    def order_time
        t = Time.now
        t.strftime("(%d/%m/%Y)")
    end

    def order_ref_number
        "#{Array('A'..'Z').sample}#{rand 1000..9999}"
    end

end