class Api::V1::ProductsController < ApplicationController 
    def index
        @products = Product.limit(params[:limit]).offset(params[:offset])
        #render json: @products, each_serializer: ProductSerializer
        render json: { total_results: number_of_records , products: ActiveModelSerializers::SerializableResource.new(@products, 
    {each_serializer: ProductSerializer})}
    end

    private
    def number_of_records
        Product.all.count
    end
end