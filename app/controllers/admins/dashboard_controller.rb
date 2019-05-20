class Admins::DashboardController < Admins::BaseController
  add_breadcrumb I18n.t('breadcrumbs.homepage'), :admins_root_path
  def index; end
end
