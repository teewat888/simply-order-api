class Api::V1::HomeController < Api::AppController
    def first_page
        render json: { success: true, message: "Welcome to simply order API services" }
        #raise TPError.new("Bad request")
    end
end