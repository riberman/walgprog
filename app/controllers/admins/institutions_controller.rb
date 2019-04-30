class Admins::InstitutionsController < Admins::BaseController

  before_action :set_institution, only: [:edit, :update, :destroy]

  def index
    @institutions = Institution.all.order(:name)
  end

  def new
    @institution = Institution.new
    @states = State.order(:name)
    @cities = []
  end

  def create
    @institution = Institution.new(institution_params)
    if @institution.save
      flash[:success] = t('institutions.success.new')
      redirect_to admins_institutions_path
    else
      @states = State.order(:name)
      @cities = params[:institution][:state_id].empty? ? [] : @institution.city.state.cities
      render :new
    end
  end

  def edit
    find_states_and_cities
  end

  def update
    if @institution.update(institution_params)
      flash[:success] = t('institutions.success.edit')
      redirect_to admins_institutions_path
    else
      find_institution
      find_states_and_cities
      flash[:error] = t('simple_form.error_notification.default_message')
      render 'edit'
    end
  end

  def destroy
    find_institution
    @institution.destroy
    flash[:success] = t('institutions.success.destroy')

    redirect_to admins_institutions_path
  end

  protected

  def institution_params
    params.require(:institution).permit(:name, :acronym, :city_id)
  end

  def find_states_and_cities(*)
    @states = State.order(:name)
    state = @institution.city.state
    @cities = state.cities
  end

  def set_institution
    @institution = Institution.find(params[:id])
  end
end
