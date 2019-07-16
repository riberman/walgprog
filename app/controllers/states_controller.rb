class StatesController < ApplicationController
  def cities
    @cities = State.find(params[:id]).cities.order(:name)
    render json: { cities: @cities }
  end
end
