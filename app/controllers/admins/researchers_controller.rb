class Admins::ResearchersController < Admins::BaseController

  def index
    @researchers = Researcher.includes(:institution, :scholarity).order(:name)
  end
end