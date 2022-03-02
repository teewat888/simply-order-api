class Api::V1::AuthController < ApplicationController
  before_action :authorized, except: [:sign_in]

  def sign_in
    @user = User.find_by(email: user_login_params[:email])
    #User#authenticate comes from BCrypt
    @user = @user.try(:authenticate, user_login_params[:password])
    if @user
    # encode token comes from AppController
      token = encode_token(@user.auth_token)
      render json: {
               user: UserSerializer.new(@user),
               jwt: token,
             },
             status: :accepted
    else
      render json: {
               message: 'Invalid username or password',
             },
             status: :unauthorized
    end
    
  end

  def sign_out
    #force change auth_token
    current_user_api.update(auth_token: current_user_api.gen_auth_token(true))
    # c_user.gen_auth_token(true)
    # c_user.save

    render json: { success: true, message: "You have signed out sucessfully!" }

  end

  private
  def user_login_params
    # params { user: {email: 'Chandler Bing', password: 'hi' } }
    params.require(:user).permit(:email, :password)
  end

end
