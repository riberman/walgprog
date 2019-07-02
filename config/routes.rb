Rails.application.routes.draw do
  root to: 'home#index'

  get 'contacts/:id/confirm_unregister/:token',
      to: 'contacts#confirm_unregister', as: :contact_confirm_unregister

  patch 'contacts/:id/unregister/:token',
        to: 'contacts#unregister', as: :contact_unregister

  get 'contacts/:id/edit/:token',
      to: 'contacts#edit', as: :contact_edit

  patch 'contacts/:id/update/:token',
        to: 'contacts#update', as: :contact_update

  get 'contacts/updated',
      to: 'contacts#updated', as: :contact_updated

  get 'contacts/time_exceeded',
      to: 'contacts#time_exceeded', as: :contact_time_exceeded

  get 'contacts/unregistered',
      to: 'contacts#unregistered', as: :contact_unregistered

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
