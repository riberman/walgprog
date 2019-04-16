class Admins::EventsController < ApplicationController
  layout 'layouts/admins/application'

  protected

  def after_update_path_for(*)
    events_path
  end

  public

  def index
    @navigation = [ { :title => t('events.index'), :url => admins_events_path } ]

    @events = Event.all.order("created_at desc")
  end

  def new
    @navigation = [ { :title => t('events.index'), :url => admins_events_path } ]
    @event = Event.new
  end

  def create
    @navigation = [ { :title => t('events.index'), :url => admins_events_path } ]
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = t('events.success.new')
      redirect_to admins_events_path
    else
      render 'new'
    end
  end

  def show; end

  def edit
    @navigation = [ { :title => t('events.index'), :url => admins_events_path } ]
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
    @event.destroy if !!@event

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
end
