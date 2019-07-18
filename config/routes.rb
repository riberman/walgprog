Rails.application.routes.draw do
  root to: 'home#index'

  get '/institutions',
      to: 'institutions#new', as: :new_institution

  post '/institutions',
       to: 'institutions#create'

  get '/contacts',  to: 'contacts#new', as: :new_contact

  post '/contacts', to: 'contacts#create'

  get 'contacts/:id/registration_confirmation/:token',
      to: 'contacts#registration_confirmation', as: :contact_registration_confirmation

  get 'contacts/:id/unregister_confirmation/:token',
      to: 'contacts#unregister_confirmation', as: :contact_unregister_confirmation

  patch 'contacts/:id/unregister/:token',
        to: 'contacts#unregister', as: :contact_unregister

  get 'contacts/:id/edit/:token',
      to: 'contacts#edit', as: :contact_edit

  patch 'contacts/:id/update/:token',
        to: 'contacts#update', as: :contact_update

  get 'contacts/feedback',
      to: 'contacts#feedback', as: :contact_feedback

  get 'states/:id/cities',
      to: 'states#cities', as: :state_cities

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'

      get 'institutions/approved',
          to: 'institutions#approved', as: :institutions_approved

      get 'institutions/not_approved',
          to: 'institutions#not_approved', as: :institutions_not_approved

      get 'contacts/unregistered',
          to: 'contacts#unregistered', as: :contacts_unregistered

      get 'contacts/registered',
          to: 'contacts#registered', as: :contacts_registered

      resources :contacts
      resources :institutions
      resources :admins, expect: :show
      resources :researchers
      resources :events do
        resources :sections do
          collection { patch :sort }
        end
        resources :sponsors, only: [:index, :create, :destroy]
      end
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
