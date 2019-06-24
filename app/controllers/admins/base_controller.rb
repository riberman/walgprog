class Admins::BaseController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'layouts/admins/application'

  add_breadcrumb I18n.t('breadcrumbs.homepage'), :admins_root_path

  protected

  def action_success?(action_result, options)
    if action_result
      flash[:success] = I18n.t(options[:action], resource_name: options[:model_name])
      redirect_to options[:path]
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render options[:redirect_to]
    end
  end
end
