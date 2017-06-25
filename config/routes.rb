Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles, :only => %w(create) do
    post 'rate', :on => :member

    collection do
      get 'top_rating'
      get 'public_ips'
    end
  end
end
