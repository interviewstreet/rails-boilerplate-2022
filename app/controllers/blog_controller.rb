class BlogController < ApplicationController
  include BlogHelper

  before_action :authenticate_user!
  before_action :validate_blog, only: %w[show update delete get_keyword_frequency]

  def show
    param! :blog_id, Integer, min: 1

    res = {
      error: false,
      message: 'Blog fetched',
      data: {}
    }

    begin
      res[:data][:blog] = @blog
    rescue StandardError => e
      res[:error] = true
      res[:message] = 'Something went wrong'
    end

    render json: res,
           status: res[:error] ? :bad_request : :ok
  end

  def index
    res = {
      error: false,
      message: 'Blogs fetched',
      data: {}
    }

    begin
      user_blogs, ordered_blog_ids = get_user_blogs(user: current_user)
      res[:data][:blog] = user_blogs
      res[:data][:ordered_blog_ids] = ordered_blog_ids
    rescue StandardError => e
      res[:error] = true
      res[:message] = 'Something went wrong'
    end

    render json: res,
           status: res[:error] ? :bad_request : :ok
  end

  def get_keyword_frequency
    param! :blog_id, Integer, min: 1

    res = {
      error: false,
      message: 'Blog fetched',
      data: {}
    }

    begin
      keywords_found = @blog.get_keyword_frequency
      res[:data][:keywords_found] = keywords_found
    rescue StandardError => e
      res[:error] = true
      res[:message] = 'Something went wrong'
    end

    render json: res,
           status: res[:error] ? :bad_request : :ok
  end
  
  def create
    param! :name, String, required: true, blank: false
    param! :content, Hash, required: true, blank: false do |key|
      key.param! :keywords, Array, required: true, blank: false do |element, index|
        element.param! index, String, required: true, blank: false
      end
      key.param! :body, String, required: true, blank: false
    end

    res = {
      error: false,
      message: 'Blog created',
      data: {}
    }

    begin
      new_blog = Blog.new(
        name: params[:name],
        content: params[:content],
        user: current_user
      )
      new_blog.save!
      res[:data][:blog] = {
        id: new_blog.id
      }
    rescue StandardError => e
      res[:error] = true
      res[:message] = 'Something went wrong'
    end

    render json: res,
           status: res[:error] ? :bad_request : :ok
  end
  
  def update
    param! :blog_id, Integer, min: 1
    param! :name, String, required: false, blank: false
    param! :content, Hash, required: false, blank: false do |key|
      key.param! :keywords, Array, required: false, blank: false do |element, index|
        element.param! index, String, required: false, blank: false
      end
      key.param! :body, String, required: false, blank: false
    end

    res = {
      error: false,
      message: 'Blog updated',
      data: {}
    }

    begin
      @blog.name = params[:name] if params[:name].present?
      @blog.content[:keywords] = params[:content][:keywords] if params[:content][:keywords].present?
      @blog.content[:body] = params[:content][:body] if params[:content][:body].present?
      @blog.save!
    rescue StandardError => e
      res[:error] = true
      res[:message] = 'Something went wrong'
    end

    render json: res,
           status: res[:error] ? :bad_request : :ok
  end
  
  def delete
    param! :blog_id, Integer, min: 1

    res = {
      error: false,
      message: 'Blog deleted',
      data: {}
    }

    begin
      @blog.destroy
    rescue StandardError => e
      res[:error] = true
      res[:message] = 'Something went wrong'
    end

    render json: res,
           status: res[:error] ? :bad_request : :ok
  end

  private

  def validate_blog
    @blog = Blog.find_by(id: params[:blog_id], user: current_user)
    if @blog.nil?
      return render json: { error: true, message: 'Blog not found', data: {} },
        status: :not_found
    end
  end
end