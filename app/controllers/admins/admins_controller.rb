class Admins::AdminsController < Admins::BaseController
  before_action :set_resource_name, only: [:create, :update, :destroy]
  before_action :set_admin, only: [:edit, :update, :destroy]
  before_action :authorized, only: [:new, :edit, :update, :destroy]

  add_breadcrumb I18n.t('breadcrumbs.action.index',
                        resource_name: I18n.t('activerecord.models.admin.other')),
                 :admins_admins_path, except: :destroy

  add_breadcrumb I18n.t('breadcrumbs.action.new.m',
                        resource_name: I18n.t('activerecord.models.admin.one')),
                 :new_admins_admin_path, only: [:new, :create]

  add_breadcrumb I18n.t('breadcrumbs.action.edit',
                        resource_name: I18n.t('activerecord.models.admin.one')),
                 :edit_admins_admin_path, only: [:edit, :update]

  def index
    @admins = Admin.order(name: :asc)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:success] = I18n.t('flash.actions.create.m', resource_name: @resource_name)
      redirect_to admins_admins_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def edit; end

  def update
    if @admin.update(admin_params)
      flash[:success] = I18n.t('flash.actions.update.m', resource_name: @resource_name)
      redirect_to admins_admins_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @admin.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m', resource_name: @resource_name)
    redirect_to admins_admins_path
  end

  protected

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:name, :email,
                                  :image, :image_cache,
                                  :password,
                                  :password_confirmation, :user_type)
  end

  def set_resource_name
    @resource_name = Admin.model_name.human
  end

  def authorized
    return if current_admin.admin?

    flash[:error] = I18n.t('flash.not_authorized')
    redirect_to admins_admins_path
  end
end
