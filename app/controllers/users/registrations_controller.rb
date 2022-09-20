# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  include RackSessionFix

  def create
    build_resource(sign_up_params)

    if resource.email.nil? || resource.password.nil? || params[:user][:name].nil?
      resource.errors.add('params error:', 'please provide all required params')
    else
      resource.name = params[:user][:name]
      resource.role = 'user'
      resource.save

      yield resource if block_given?

      sign_up(resource_name, resource) if resource.persisted? && resource.active_for_authentication?
    end

    respond_with resource
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        message: 'Signed up sucessfully.',
        error: false,
        data: resource.details
      }, status: :ok
    else
      render json: {
        message: resource.errors.full_messages.to_sentence.to_s,
        error: true,
        data: {}
      }, status: :unprocessable_entity
    end
  end
end
