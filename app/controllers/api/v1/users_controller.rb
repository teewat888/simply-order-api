class Api::V1::UsersController < ApplicationController
    before_action :authorized, except: [:sign_up, :index]

    def index
        if (params[:role_id])
            users = Role.find(params[:role_id]).users
            render json: { success: true, vendors: ActiveModelSerializers::SerializableResource.new(users, 
        {each_serializer: UserSerializer})}
        end
    end

    def sign_up
        @user = User.create(user_params)
        if @user.valid?
            @token = encode_token(@user.auth_token)
            render json: { success: true, jwt: @token }, status: :created
        else
            render json: {
                    success: false,
                    errors: @user.errors.as_json
                    },
                    status: :unprocessable_entity
        end

    end

    def profile
        render json: { success: true, message: "This is your profile", user: UserSerializer.new(current_user_api) }
    end 

    private

    def user_params 
        params.require(:user).permit(:email, :password, :first_name, :last_name, :company_name, :address_number, :address_street, :address_suburb, :address_state, :contact_number, :role_id)
    end

end