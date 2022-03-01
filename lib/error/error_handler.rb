module Error
    module ErrorHandler
    def self.included(base)
      base.class_eval do
        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(:record_not_found, 404, e.to_s)
        end
        rescue_from TPError do |e|
          respond(:bad_request, 400, e.to_s)
        end
        rescue_from TPAuthError do |e|
          respond(:unauthorized, 401, e.to_s)
        end
      end
    end

    private
    def respond(_error, _status, _message)
      json = Helpers::Render.json(_error, _status, _message)
      render json: json, status: _status
    end
    
  end
end