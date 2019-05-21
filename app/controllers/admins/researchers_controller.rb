class Admins::ResearchersController < Admins::BaseController
  add_breadcrumb t('breadcrumbs.action.index',
                   resource_name: I18n.t('activerecord.models.researcher.other')),
                 :admins_researchers_path
  def index
    @researchers = Researcher.includes(:institution, :scholarity).order(:name)
  end
end