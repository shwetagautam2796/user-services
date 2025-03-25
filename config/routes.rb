Rails.application.routes.draw do
  devise_for :users,
              controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             },
             defaults: { format: :json }
  post 'auth/validate_token', to: 'authentication#validate_token'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
