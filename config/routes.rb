Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'

      resources :contacts
      resources :institutions
      resources :events

      get 'states/:id/cities',
          to: 'states#cities', as: :state_cities

      get 'contact/:id/unregister/:token',
          to: 'contacts#unregister', as: :contact_unregister

      get 'contact/:id/update/:token',
          to: 'contacts#self_update', as: :contact_self_update

      get 'contact/unregistered',
          to: 'contacts#unregistered', as: :contacts_unregistered

      get 'contact/registered',
          to: 'contacts#registered', as: :contacts_registered
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
