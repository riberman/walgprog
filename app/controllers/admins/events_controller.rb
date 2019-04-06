class Admins::EventsController < ApplicationController
  layout 'layouts/admins/application'

  protected

  def after_update_path_for(*)
    admin_events_path
  end

  public

  def index; end

  def new
    @event = Event.new
  end

  def create
    params.require(:event).permit(
      :name,
      :initials,
      :color,
      :beginning_date,
      :end_date,
      :local,
      :city_id,
      :state_id
    )
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end
end
