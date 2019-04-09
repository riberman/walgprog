class Admins::RegistrationsController < Devise::RegistrationsController
  layout 'layouts/admins/application'

  protected

  def after_update_path_for(*)
    edit_admin_registration_path
  end

  def account_update_params
    params.require(:admin).permit(:name, :email,
                                  :image, :image_cache,
                                  :current_password,
                                  :password,
                                  :password_confirmation)
  end
end
