class Users::UserController < ApplicationController
  before_action :authenticate_user!, only: ['get_details']

  def get_details
    res = {
      error: false,
      message: 'user details fetched',
      data: {
        user: {}
      }
    }

    begin
      user = current_user
      res[:data][:user] = user.details
    rescue StandardError => e
      res[:error] = true
      res[:message] = 'something went wrong'

      Honeybadger.notify(e, context: {
                           hint: 'Error in listing actions',
                           user_id: current_user.id
                         })
    end

    render json: res,
           status: res[:error] ? :bad_request : :ok
  end
end
