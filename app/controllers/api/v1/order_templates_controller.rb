class Api::V1::OrderTemplatesController < ApplicationController
    
    def new 
        if (params[:vendor_id])
            render json: { success: true, vendor_id: params[:vendor_id], products: Product.available_products_for_template(params[:vendor_id])}
        
        end
    end


    private

end