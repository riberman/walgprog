class Admins::InstitutionsController < Admins::BaseController
  add_breadcrumb I18n.t('breadcrumbs.homepage'), :admins_root_path

  add_breadcrumb I18n.t('breadcrumbs.action.index',
                        resource_name: I18n.t('activerecord.models.institution.other')),
                 :admins_institutions_path, only: [:index, :new, :create, :edit, :update]

  add_breadcrumb I18n.t('breadcrumbs.action.new.f',
                        resource_name: I18n.t('activerecord.models.institution.one')),
                 :new_admins_institution_path, only: [:new, :create]

  add_breadcrumb I18n.t('breadcrumbs.action.edit',
                        resource_name: I18n.t('activerecord.models.institution.one')),
                 :edit_admins_institution_path, only: [:edit, :update]

  before_action :set_resource_name, only: [:create, :update, :destroy]
  before_action :set_institution, only: [:edit, :update, :destroy]
  before_action :load_states, only: [:new, :create, :edit, :update]

  def index
    @institutions = Institution.includes(city: [:state]).order(name: :asc)
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

  def load_states
    @states = State.order(:name)
    @cities = []
  end

  def load_cities
    state = @institution.state
    @cities = state.cities if state
  end

  def set_resource_name
    @resource_name = Institution.model_name.human
  end
end
