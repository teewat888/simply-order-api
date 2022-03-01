class Api::V1::UsersController < Api::AppController
    def profile
        render json: { success: true, message: "This is your profile" }
    end 
end