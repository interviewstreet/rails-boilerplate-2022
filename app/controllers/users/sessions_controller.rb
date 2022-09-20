# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  before_action :check_params, only: [:create]

  ## POST users/sign_in
  def create
    self.resource = warden.authenticate(auth_options)
    sign_in(resource_name, resource) unless resource.nil?
    respond_with resource
  end

  private

  def check_params
    if %i[email password].any? { |p| !(params[:user] && params[:user][p].present?) }
      render json: {
        error: true,
        message: 'missing params'
      }, status: :bad_request
    end
  end

  # overriding this to send the response in json
  def respond_with(resource, _opts = {})
    if user_signed_in?
      render json: create_response(resource), status: :ok
    else
      render json: create_response, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    head :no_content
  end

  def create_response(user = nil)
    res = {}
    if user.nil?
      res[:error] = true
      res[:message] = 'Invalid Email or Password'
      res[:data] = {}
    else
      res[:error] = false
      res[:message] = 'Login successful'
      res[:data] = user.details
    end
    res
  end
end
