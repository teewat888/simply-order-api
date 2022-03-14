class Api::V1::ProductsController < ApplicationController 
    before_action :set_product, only: [:show, :update, :destroy]
    before_action :authorized, except: [:index, :show]

    def index
        if (params[:mode] === 'myproduct')
            if params[:user_id]
           @products = User.find(params[:user_id]).products.limit(params[:limit]).offset(params[:offset])
           render json: { success: true, total_results: @products.count , products: ActiveModelSerializers::SerializableResource.new(@products, 
        {each_serializer: ProductSerializer})}
            end
        elsif (params[:mode] === 'template') #get product that available for template
            render json: { success: true, vendor_id: params[:user_id], products: Product.available_products_for_template(user: params[:user_id])}
        end
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
   
    def set_product
        @product = Product.find(params[:id])
    end

    def product_params
        params.require(:product).permit(:id,:name, :brand, :unit,:available, :vendor_id)
    end
end