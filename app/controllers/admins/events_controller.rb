class Admins::EventsController < Admins::BaseController
  before_action :set_resource_name, only: [:create, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  include VirtualState::Controller

  add_breadcrumb I18n.t('breadcrumbs.action.index',
                        resource_name: I18n.t('activerecord.models.event.other')),
                 :admins_events_path, except: :destroy

  add_breadcrumb I18n.t('breadcrumbs.action.new.m',
                        resource_name: I18n.t('activerecord.models.event.one')),
                 :new_admins_event_path, only: [:new, :create]

  add_breadcrumb I18n.t('breadcrumbs.action.edit',
                        resource_name: I18n.t('activerecord.models.event.one')),
                 :edit_admins_event_path, only: [:edit, :update]

  add_breadcrumb I18n.t('breadcrumbs.event.detail',
                        resource_name: I18n.t('activerecord.models.event.one')),
                 :admins_event_path, only: [:show]

  def index
    @events = Event.order(created_at: :desc)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = t('flash.actions.create.m', resource_name: @resource_name)
      redirect_to admins_events_path
    else
      load_cities
      flash.now[:error] = I18n.t('flash.actions.errors')
      render 'new'
    end
  end

  def show; end

  def edit
    load_cities
  end

  def update
    if @event.update event_params
      flash[:success] = t('flash.actions.update.m', resource_name: @resource_name)
      redirect_to admins_events_path
    else
      load_cities
      flash.now[:error] = I18n.t('flash.actions.errors')
      render 'edit'
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = t('flash.actions.destroy.m', resource_name: @resource_name)
    else
      flash[:alert] = t('flash.actions.bond', resource_name: @resource_name)
    end

    redirect_to admins_events_path
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :initials, :color,
      :beginning_date, :end_date,
      :local, :address,
      :city_id, :state_id
    )
  end

  def set_resource_name
    @resource_name = Event.model_name.human
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
