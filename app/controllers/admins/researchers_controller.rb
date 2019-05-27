class Admins::ResearchersController < Admins::BaseController
  add_breadcrumb I18n.t('breadcrumbs.action.index',
                        resource_name: I18n.t('activerecord.models.researcher.other')),
                 :admins_researchers_path, except: :destroy

  add_breadcrumb I18n.t('breadcrumbs.action.new.m',
                        resource_name: I18n.t('activerecord.models.researcher.one')),
                 :new_admins_researcher_path, only: [:new, :create]

  add_breadcrumb I18n.t('breadcrumbs.action.edit',
                        resource_name: I18n.t('activerecord.models.researcher.one')),
                 :edit_admins_researcher_path, only: [:edit, :update]

  add_breadcrumb I18n.t('breadcrumbs.action.show',
                        resource_name: I18n.t('activerecord.models.researcher.one')),
                 :admins_researcher_path, only: :show

  before_action :set_resource_name, only: [:create, :update, :destroy]
  before_action :find_institutions, only: [:new, :create, :edit, :update]
  before_action :find_scholarity, only: [:new, :create, :edit, :update]
  before_action :find_researcher, except: [:new, :create, :index]

  def index
    @researchers = Researcher.includes(:institution, :scholarity).order(:name)
  end

  def new
    @researcher = Researcher.new
  end

  def create
    @researcher = Researcher.new(researcher_params)
    if @researcher.save
      flash[:success] = t('flash.actions.create.m', resource_name: @resource_name)
      redirect_to admins_researchers_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @researcher.update researcher_params
      flash[:success] = t('flash.actions.update.m', resource_name: @resource_name)
      redirect_to admins_researchers_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render 'edit'
    end
  end

  def destroy
    @researcher.destroy if @researcher.present?
    flash[:success] = t('flash.actions.destroy.m', resource_name: @resource_name)
    redirect_to admins_researchers_path
  end

  private

  def researcher_params
    params.require(:researcher).permit(
        :name,
        :scholarity_id,
        :genre,
        :institution_id,
        :image, :image_cache
    )
  end

  def set_resource_name
    @resource_name = Researcher.model_name.human
  end

  def find_institutions
    @institutions = Institution.all.order(:name)
  end

  def find_scholarity
    @scholarities = Scholarity.all.order(:name)
  end
  def find_researcher
    @researcher = Researcher.find(params[:id])
  end
end
