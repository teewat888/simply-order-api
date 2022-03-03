class Api::V1::ProductsController < ApplicationController 
    def index
        @products = Product.limit(params[:limit]).offset(params[:offset])
        render json: { num_of_products: number_of_records, products: @products }
    end

    private
    def number_of_records
        Product.all.count
    end
end