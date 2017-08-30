Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  # API, JSON-only
  constraints lambda { |req| req.format == :json && req.subdomain == 'api' } do
	  resources :facts
	end

	resources :clients
end
