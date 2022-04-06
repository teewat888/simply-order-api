class Api::V1::AuthController < ApplicationController
  before_action :authorized, except: [:sign_in, :sign_up]

  def sign_in
    @user = User.find_by(email: user_params[:email])
    #User#authenticate comes from BCrypt
    @user = @user.try(:authenticate, user_params[:password])
    if @user
    # encode token comes from AppController
      token = encode_token(@user.auth_token)
      response.headers["jwt"] = token
      #need to remove the below render jwt -> hkeep for testing purpose
      render json: {
              success: true,
              user: UserSerializer.new(@user),
              jwt: token
             },
             status: :accepted
    else
      render json: {
              success: false,
              message: 'Invalid username or password',
             },
             status: :unauthorized
    end
    
  end

   def sign_up
        @user = User.create(user_params)
        if @user.valid?
            token = encode_token(@user.auth_token)
            response.headers["jwt"] = token
            render json: { success: true, user: UserSerializer.new(@user), message: "Sign up successfully." }, status: :created
        else
            render json: {
                    success: false,
                    message: error_text(@user.errors),
                    errors: @user.errors.as_json
                    },
                    status: :unprocessable_entity
        end

    end

  def sign_out
    #force change auth_token
    current_user_api.update(auth_token: current_user_api.gen_auth_token(true))
    render json: { success: true, message: "You have signed out sucessfully!" }
  end

  private
  def user_params 
    params.require(:user).permit(:email, :password, :first_name, :last_name, :company_name, :address_number, :address_street, :address_suburb, :address_state, :contact_number, :role_id)
  end

 

end
