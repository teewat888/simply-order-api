class Api::V1::HomeController < ApplicationController
    def first_page
        render json: { success: true, message: "Welcome to simply order API services" }   
    end
end