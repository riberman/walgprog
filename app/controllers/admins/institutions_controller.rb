class Admins::InstitutionsController < Admins::BaseController


  def new
    @institution = Institution.new
    @states = State.order(:name)
  end

  protected

  def institution_params
    params.require(:institution).permit(:name,
                                        :acronym,
                                        :state_id,
                                        :city_id)
  end

end


