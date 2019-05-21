class Admins::BaseController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'layouts/admins/application'

  add_breadcrumb I18n.t('breadcrumbs.homepage'), :admins_root_path
end
