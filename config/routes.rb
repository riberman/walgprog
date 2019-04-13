Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :admins
  authenticate :admin do
    namespace :admins do
      root to: 'dashboard#index'
    end
  end

  as :admin do
    get '/admins/edit',
        to: 'admins/registrations#edit',
        as: 'edit_admin_registration'

    put '/admins',
        to: 'admins/registrations#update',
        as: 'admin_registration'

    get 'admins/events',
        to: 'admins/events#index',
        as: 'admin_events'

    get 'admins/events/new',
        to: 'admins/events#new',
        as: 'admins_events_new'

    post 'admins/events/create',
         to: 'admins/events#create',
         as: 'admins_events_create'

    get 'admins/events/edit',
        to: 'admins/events#edit',
        as: 'admins_events_edit'

    put 'admins/events/update',
        to: 'admins/events#update',
        as: 'admins_events_update'

    get 'admins/events/show',
        to: 'admins/events#show',
        as: 'admins_events_show'

    delete 'admins/events/destroy',
           to: 'admins/events#destroy',
           as: 'admins_events_destroy'
  end
end
