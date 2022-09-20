class PublicationController < ApplicationController  
  include PublicationHelper
  
  before_action :authenticate_user!

  def user_blogs
    param! :publication_id, Integer, min: 1

    res = {
      error: false,
      message: 'User blogs fetched',
      data: {}
    }

    begin
      blogs_hash, ordered_blog_ids = get_user_blogs(user: current_user)
      res[:data][:blogs] = blogs_hash
      res[:data][:ordered_blog_ids] = ordered_blog_ids
    rescue StandardError => e
      puts "error", e
      res[:error] = true
      res[:message] = 'Something went wrong'
    end

    render json: res,
         status: res[:error] ? :bad_request : :ok
  end
end