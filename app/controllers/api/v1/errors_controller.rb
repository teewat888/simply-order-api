class Api::V1::ErrorsController < Api::AppController
  def not_found
    render json: {
      status: 404,
      error: :not_found,
      message: 'Sorry, we can not find your request!'
    }, status: 404
  end

  def internal_server_error
    render json: {
      status: 500,
      error: :internal_server_error,
      message: 'Hey admin, something error here!'
    }, status: 500
  end
end