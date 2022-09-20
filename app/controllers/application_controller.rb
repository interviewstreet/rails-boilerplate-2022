class ApplicationController < ActionController::API
  rescue_from RailsParam::InvalidParameterError do |e|
    render json: {
      error: true,
      message: e,
      data: {}
    }, status: :bad_request
  end
end
