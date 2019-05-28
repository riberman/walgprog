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

  before_action :find_researcher, except: [:new, :create, :index]
  before_action :find_scholarity, except: [:destroy, :index, :show]
  before_action :find_institutions, except: [:destroy, :index, :show]

  def index
    @researchers = Researcher.includes(:institution, :scholarity).order(:name)
  end

  def new
    @researcher = Researcher.new
  end

  def create
    @researcher = Researcher.new(researcher_params)
    action_success? @researcher.save, :new, 'flash.actions.create.m'
  end

  def show; end

  def edit; end

  def update
    action_success? @researcher.update(researcher_params), :edit, 'flash.actions.update.m'
  end

  def destroy
    @researcher.destroy if @researcher.present?
    flash[:success] = t('flash.actions.destroy.m', resource_name: Researcher.model_name.human)
    redirect_to admins_researchers_path
  end

  private

  def action_success?(action_result, redirect_to, action)
    if action_result
      flash[:success] = I18n.t(action, resource_name: t('activerecord.models.researcher.one'))
      redirect_to admins_researchers_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render redirect_to
    end
  end

  def researcher_params
    params.require(:researcher).permit(:name, :scholarity_id, :genre, :institution_id, :image,
                                       :image_cache)
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
