class Admins::DashboardController < Admins::BaseController
  def index
    @institutions = Institution.where(approved: false)
  end
end
