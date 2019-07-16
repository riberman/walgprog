class InstitutionsController < ApplicationController

  layout 'layouts/institution'

  include VirtualState::Controller

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params)
    if @institution.save
      flash[:success] = I18n.t('flash.actions.create.f', resource_name: @resource_name)
      redirect_to institutions_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      load_cities
      render :new
    end
  end

  protected

  def institution_params
    params.require(:institution).permit(:name, :acronym, :city_id, :state_id)
  end

  def set_institution
    @institution = Institution.find(params[:id])
  end

  def set_resource_name
    @resource_name = Institution.model_name.human
  end
end