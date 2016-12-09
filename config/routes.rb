Rails.application.routes.draw do
  # mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "facts#index"
  get "/pages/about" => "pages#about", as: :about
  resources :facts do
    resources :sources
  end

  resources :sources do
  	member do
  		post 'upvote'
  	end
  end

    resources :sources do
    member do
      post 'downvote'
    end
  end
  
  resources :upvote

  resources :users

  get "/log-in" => "sessions#new", as: :login
  post "/log-in" => "sessions#create"
  get "/log-out" => "sessions#destroy", as: :log_out
end
