Rails.application.routes.draw do
  root to: 'home#index'

  get '/contacts', to: 'contacts#new', as: :new_contact

  post '/contacts', to: 'contacts#create'

  get 'contacts/:id/edit/:update_data_token',
      to: 'contacts#update', as: :update_contact
  
  get 'contacts/:id/unregister/:unregister_token',
      to: 'contacts#unregister', as: :contact_unregister


  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'

      resources :contacts
      resources :institutions
      resources :admins, expect: :show
      resources :researchers
      resources :events do
        resources :sponsors, only: [:index, :create, :destroy]
      end

      get 'states/:id/cities',
          to: 'states#cities', as: :state_cities
    end
  end

  as :admin do
    get '/admins/edit',
        to: 'admins/registrations#edit',
        as: 'edit_admin_registration'

    put '/admins',
        to: 'admins/registrations#update',
        as: 'admin_registration'
  end
end
