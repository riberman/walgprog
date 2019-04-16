class Admins::CitiesController < Admins::BaseController

  def search_cities_by_state
    @cities = City.where('state_id' => params[:state_id]).order(:name)
    render :json => {:cities => @cities}
  end
end