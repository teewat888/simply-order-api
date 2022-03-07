class Api::V1::ProductsController < ApplicationController 
    before_action :set_product, only: [:show, :update, :destroy]
    before_action :authorized, except: [:index, :show]

    def index
        @products = Product.limit(params[:limit]).offset(params[:offset])
        #render json: @products, each_serializer: ProductSerializer
        render json: { total_results: number_of_records , products: ActiveModelSerializers::SerializableResource.new(@products, 
    {each_serializer: ProductSerializer})}
    end

    def create
        product = Product.new(product_params)
        if product.save
            render json: { success: true, product: ProductSerializer.new(product)}
        else
            render json: { success: false, message: "Error when creating a product" }
        end
        
    end

    def show
        render json: {status: 200, product: ProductSerializer.new(@product)}
    end

    def update
        if @product.update(product_params)
            render json: { success: true, product: ProductSerializer.new(@product)}
        else
            render json: { success: false, message: "Error when updating a product" }
        end

    end

    def destroy
        @product.destroy
        render json: { success: true }
    end

    private
    def number_of_records
        Product.all.count
    end

    def set_product
        @product = Product.find(params[:id])
    end

    def product_params
        params.permit(:id,:name, :brand, :unit, :vendor_id)
    end
end