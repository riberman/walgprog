class Admins::InstitutionsController < Admins::BaseController


  def new
    @institution = Institution.new
    @states = State.order(:name)
    end

  def create
    @institution = Institution.new(institution_params)
    if @institution.save
      success_create_message
      redirect_to admins_root_path
    else
      # error_message
      render :new
    end
  end



  protected

  def institution_params
    params.require(:institution).permit(:name,
                                        :acronym,
                                        :state_id,
                                        :city_id)
  end

end


