class Admins::InstitutionsController < Admins::BaseController

  def index
    @institutions = Institution.all
  end

  def new
    @institution = Institution.new
    @states = State.order(:name)
  end

  def edit
    @institution = Institution.find(params[:id])
  end

  def create
    @institution = Institution.new(institution_params)

    if @institution.save
      redirect_to @institution
    else
      render 'new'
    end
  end

  def update
    @institution = Institution.find(params[:id])

    if @institution.update(institution_params)
      redirect_to @institution
    else
      render 'edit'
    end
  end

  def destroy
    @institution = Institution.find(params[:id])
    @institution.destroy

    redirect_to admins_institutions_path
  end

  protected

  def institution_params
    params.require(:institution).permit(:name,
                                        :acronym,
                                        :state_id,
                                        :city_id)
  end

end
