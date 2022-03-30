class Api::V1::UsersController < ApplicationController
    before_action :authorized, except: [:index, :vendor]

    def index
        if (params[:role_id])
            users = Role.find(params[:role_id]).users
            render json: { success: true, vendors: ActiveModelSerializers::SerializableResource.new(users, 
        {each_serializer: UserSerializer})}
        else
            render json: {success: true, users: User.all}
        end
    end

    def profile
        render json: { success: true, message: "This is your profile", user: UserSerializer.new(current_user_api) }
    end 

    def change_password
        user = User.find(params[:id])
        user = user.try(:authenticate, user_params[:current_password]) #check current password
        if (user) 
            if user.update({"password"=>user_params[:password]})
            #user.password = BCrypt::Password.create(self.password)
            render json: {success: true, message: "Password changed successfully."}
            end
        else
            render json: {success: false, message: "Your have no authorize to change the password."}
        end
    end

    def update 
        user = User.find(params[:id])
        if user.update(user_params)
            render json: {success: true, message: "Profile has been updated.", user: user}
        else
            render json: {success: false, message: "Error updating profile."}
        end
    end

    def vendor
        if (params[:id])
            render json: { success: true, vendor: User.find(params[:id])}
        else
            render json: {success: false, message: "Error get a vendor detail"}
        end
    end

    private


    def user_params 
        params.require(:user).permit(:email, :password, :current_password, :first_name, :last_name, :company_name, :address_number, :address_street, :address_suburb, :address_state, :contact_number, :role_id)
    end

end