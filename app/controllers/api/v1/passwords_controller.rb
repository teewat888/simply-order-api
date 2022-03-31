class Api::V1::PasswordsController < ApplicationController
    def forgot
        if params[:email].blank?
            render json: {success: false, message: "Please provide an email"}
        end

        user = User.find_by(email: params[:email])
        if user.present?
            #use jwt with expire as reset password token
            payload = { exp: token_expire_in.to_i, auth_token: user.auth_token }
            token = JWT.encode payload, secret_key, hmac_type
            # send email with link
            ResetPasswordMailer.with(user: user, token: token).send_reset_email.deliver_now
            render json: {success: true, message: "Password reset instruction email has been sent to #{user.email}"}
        else
        render json: {success: false, message: "No registered email found."}
        end

    end

    def reset
        if params[:token].blank?
            render json: {success: false, message: "No token provide"}
        end

        decrypted = decode_token(params[:token])
        if decrypted
            payload = decrypted.first
            user = User.find_by_auth_token(payload["auth_token"])
            if user
                #update password and regen auth_token to prevent to use the same token
                if user.update({password: params[:password], auth_token: user.gen_auth_token(true)})
                    render json: {success: true, message: "Successfully set new password."}
                else
                    render json: {success: false, message: "Error updating password, please try again."}
                end
            else
                render json: {success: false, message: "invalid/expire token."}
            end
        else
            render json: {success: false, message: "invalid/expire token."}
        end
  
    end

    def decode_token(token)
            begin
                JWT.decode(token, secret_key, true, algorithm: hmac_type)
            rescue JWT::DecodeError
                nil
            rescue JWT::ExpiredSignature
                nil
            end
    end

    def requested_user
        if decoded_token
            payload = decoded_token.first
            if (payload.blank? || payload["auth_token"].blank?) 
                raise TPAuthError.new("Bad Token format!")
            end
            @user = User.find_by_auth_token(payload["auth_token"])
        end
    end

    private
    def secret_key
        Rails.application.credentials.secret_key_base
    end

    def token_expire_in 
        10.minutes.from_now
    end

    def hmac_type
        'HS256'
    end
    
    

end
