class Admins::EventsController < Admins::BaseController
  before_action :set_root_pagination
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all.order(created_at: :desc).includes(:city)
  end

  def new
    @event = Event.new
    @cities = City.order(name: :desc)
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = t('flash.actions.create.m', resource_name: @event.name)
      redirect_to admins_events_path
    else
      @cities = City.order(name: :desc)
      render 'new'
    end
  end

  def show; end

  def edit
    @cities = City.order(name: :desc)
  end

  def update
    if @event.update event_params
      flash[:success] = t('flash.actions.update.m', resource_name: @event.name)
      redirect_to admins_events_path
    else
      @cities = City.order(name: :desc)
      render 'edit'
    end
  end

  def destroy
    @event.destroy if @event.present?

    flash[:success] = t('flash.actions.destroy.m', resource_name: @event.name)

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

  def set_event
    @event = Event.find(params[:id])
  end
end
