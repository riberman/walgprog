class Admins::EventsController < ApplicationController
  layout 'layouts/admins/application'

  before_action :set_root_pagination

  protected

  def after_update_path_for(*)
    events_path
  end

  public

  def index
    @events = Event.all.order(created_at: :desc).includes(:city)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = t('events.success.new')
      redirect_to admins_events_path
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update event_params
      flash[:success] = t('events.success.edit')
      redirect_to admins_events_path
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy if @event.present?

    flash[:success] = t('events.success.destroy')

    redirect_to admins_events_path
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :initials,
      :color,
      :beginning_date,
      :end_date,
      :local,
      :city_id,
      :address
    )
  end

  def set_root_pagination
    @navigation = [{ title: t('events.index'), url: admins_events_path }]
  end
end
