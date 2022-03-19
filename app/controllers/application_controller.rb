class ApplicationController < ActionController::API
    include Error::ErrorHandler
        rescue_from JWT::DecodeError, with: :rescue_unauthorized
        rescue_from JWT::ExpiredSignature, with: :rescue_unauthorized
        rescue_from JWT::ImmatureSignature, with: :rescue_unauthorized
        rescue_from JWT::InvalidIssuerError, with: :rescue_unauthorized
        rescue_from JWT::InvalidIatError, with: :rescue_unauthorized
        rescue_from JWT::VerificationError, with: :rescue_unauthorized

    def encode_token(pl)
        payload = { exp: token_expire_in.to_i, auth_token: pl }
        JWT.encode payload, secret_key, hmac_type
    end

    def auth_header
    # { Authorization: 'Bearer <token>' }
        request.headers["Authorization"].blank? ? (raise TPAuthError.new("no token provide")) : request.headers["Authorization"]
    end

    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            # header: { 'Authorization': 'Bearer <token>' }
            begin
                JWT.decode(token, secret_key, true, algorithm: hmac_type)
            rescue JWT::DecodeError
                nil
            rescue JWT::ExpiredSignature
                nil
            end
        end
    end

    def current_user_api
        if decoded_token
            payload = decoded_token.first
            if (payload.blank? || payload["auth_token"].blank?) 
                raise TPAuthError.new("Bad Token format!")
            end
            @user = User.find_by_auth_token(payload["auth_token"])
        end
    end

    def logged_in?
        !!current_user_api
    end

    def authorized
        if logged_in?
            #renew jwt in case not expire time yet
            token = encode_token(@user.auth_token) 
            response.headers["jwt"] = encode_token(@user.auth_token) 
        else
            render json: { success: false, message: 'Please log in' }, status: :unauthorized
        end
    end

    private
    def secret_key
        #Rails.application.credentials.secret_key_base
        'mysecret'
    end

    def token_expire_in
        #1.days.from_now 
        5.minutes.from_now
    end

    def hmac_type
        'HS256'
    end

    def rescue_unauthorized(err)
        render json: {success: false, error: err}, status: :unauthorized
    end

end
