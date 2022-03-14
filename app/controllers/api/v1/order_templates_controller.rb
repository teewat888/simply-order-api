class Api::V1::OrderTemplatesController < ApplicationController
    before_action :authorized, only: [:index, :create, :destroy]

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


    private

    def order_templates_params
        params.require(:order_template).permit(:user_id,:vendor_id,:name, products: [:id, :name,:brand,:unit,:in_template])
    end

end