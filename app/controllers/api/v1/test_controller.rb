class Api::V1::TestController < ApplicationController
    before_action :authorized

    def test_page
        render json: { status: true, message: "you are logged in" }
    end
end