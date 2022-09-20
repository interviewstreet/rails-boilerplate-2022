Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  scope :user do
    get 'details' => 'users/user#get_details'
  end

  resources :blogs do
    # Implies index, create, show, update, and delete methods
    get 'keywords' => 'blog#get_keyword_frequency'
  end

  scope :publication do
    get '' => 'publication#index'
    get '/user/:blog_id' => 'publication#user_blogs'
    post '' => 'publication#create'
  end
end
