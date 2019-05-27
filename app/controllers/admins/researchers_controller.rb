class Admins::ResearchersController < Admins::BaseController
  add_breadcrumb I18n.t('breadcrumbs.action.index',
                   resource_name: I18n.t('activerecord.models.researcher.other')), :admins_researchers_path

  add_breadcrumb I18n.t('breadcrumbs.action.new.m', resource_name: I18n.t('activerecord.models.researcher.one')),
                 :new_admins_researcher_path, only: [:new]

  before_action :find_institutions, only: [:new]
  before_action :find_scholarities, only: [:new]

  def index
    @researchers = Researcher.includes(:institution, :scholarity).order(:name)
  end

  def new
    @researcher = Researcher.new
  end

  private

  def find_institutions
    @institutions = Institution.all.order(:name)
  end

  def find_scholarities
    @scholarities = Researcher.all.order(:name)
  end
end