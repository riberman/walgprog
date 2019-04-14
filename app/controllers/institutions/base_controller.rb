class Institutions::BaseController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'layouts/admins/application'
end
