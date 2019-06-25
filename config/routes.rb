Rails.application.routes.draw do
  root to: 'home#index'

  get '/contacts', to: 'contacts#new', as: :new_contact
  post '/contacts', to: 'contacts#create'

  #get 'contact/:id/unregister/:token',
  #  to: 'contact#unregister' as: :contacts_unregister

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

      get 'contacts/unregistered/:token',
            to: 'contacts#unregistered', as: :contacts_unregistered

      #get 'contact/registered',
      #      to: 'contacts#registered', as: :contacts_registered

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
