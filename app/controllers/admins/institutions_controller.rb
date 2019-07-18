class Admins::InstitutionsController < Admins::BaseController
  # nested_form

  before_action :set_resource_name, only: [:create, :update, :destroy]
  before_action :set_institution, only: [:edit, :update, :destroy]

  include VirtualState::Controller

  add_breadcrumb I18n.t('breadcrumbs.action.index',
                        resource_name: I18n.t('activerecord.models.institution.other')),
                 :admins_institutions_path, except: :destroy

  add_breadcrumb I18n.t('breadcrumbs.action.new.f',
                        resource_name: I18n.t('activerecord.models.institution.one')),
                 :new_admins_institution_path, only: [:new, :create]

  add_breadcrumb I18n.t('breadcrumbs.action.edit',
                        resource_name: I18n.t('activerecord.models.institution.one')),
                 :edit_admins_institution_path, only: [:edit, :update]

  add_breadcrumb I18n.t('breadcrumbs.action.approved',
                        resource_name: I18n.t('activerecord.models.institution.other')),
                 :admins_institutions_approved_path, only: :approved

  add_breadcrumb I18n.t('breadcrumbs.action.not_approved',
                        resource_name: I18n.t('activerecord.models.institution.other')),
                 :admins_institutions_not_approved_path, only: :not_approved

  def index
    @institutions = Institution.includes(city: [:state]).order(name: :asc)
  end

  def approved
    @institutions = Institution.approved
    render :index
  end

  def not_approved
    @institutions = Institution.not_approved
    render :index
  end

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params)
    if @institution.save
      flash[:success] = I18n.t('flash.actions.create.f', resource_name: @resource_name)
      redirect_to admins_institutions_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      load_cities
      render :new
    end
  end

  def edit
    load_cities
  end

  def update
    if @institution.update(institution_params)
      flash[:success] = I18n.t('flash.actions.update.f', resource_name: @resource_name)
      redirect_to admins_institutions_path
    else
      load_cities
      flash.now[:error] = I18n.t('flash.actions.errors')
      render 'edit'
    end
  end

  def destroy
    @institution.destroy
    flash[:success] = I18n.t('flash.actions.destroy.f', resource_name: @resource_name)
    redirect_to admins_institutions_path
  end

  protected

  def institution_params
    params.require(:institution).permit(:name, :acronym, :city_id, :state_id)
  end

  def set_institution
    @institution = Institution.find(params[:id])
  end

  def set_resource_name
    @resource_name = Institution.model_name.human
  end
end
