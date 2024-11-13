Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/signup', to: 'auth#signup'
      post '/signin', to: 'auth#signin'
      delete '/signout', to: 'auth#signout'

      resources :teams do
        resources :members, controller: 'team_members', only: %i[index create destroy]
      end
    end
  end
end
