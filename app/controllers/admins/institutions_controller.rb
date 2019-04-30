class Admins::InstitutionsController < Admins::BaseController
  def index
    @institutions = Institution.all
  end

  def new
    @institution = Institution.new
    @states = State.order(:name)
  end

  def create
    @institution = Institution.new(institution_params)
    if @institution.save
      flash[:success] = 'Instituição caadastrada com sucesso.'
      redirect_to admins_institutions_path
    else
      # error_message
      render :new
    end
  end

  def edit
    @institution = Institution.find(params[:id])
    @states = State.order(:name)
    state = @institution.city.state
    @cities = state.cities
  end

  def update
    @institution = Institution.find(params[:id])

    if @institution.update(institution_params)
      flash[:success] = 'Instituição atualizada com sucesso.'
      redirect_to admins_institutions_path
    else
      render 'edit'
    end
  end

  def destroy
    @institution = Institution.find(params[:id])
    @institution.destroy
    flash[:success] = 'Instituição apagada com sucesso.'
    redirect_to admins_institutions_path
  end

  protected

  def institution_params
    params.require(:institution).permit(:name, :acronym, :city_id, :search)
  end
end
