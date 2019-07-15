Rails.application.routes.draw do
  root to: 'home#index'

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

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'

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
