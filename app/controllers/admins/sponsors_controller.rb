class Admins::SponsorsController < Admins::BaseController
  add_breadcrumb I18n.t('breadcrumbs.action.index',
                        resource_name: I18n.t('activerecord.models.event.other')),
                 :admins_events_path, only: [:index]

  add_breadcrumb I18n.t('breadcrumbs.action.index',
                        resource_name: I18n.t('activerecord.models.sponsor.other')),
                 :admins_event_sponsors_path, only: [:index]

  before_action :set_event
  before_action :load_sponsors

  def index
    @sponsors = @event.sponsors
  end

  def create
    sponsor = Institution.find(params[:sponsor][:id])
    @event.sponsors << sponsor
    redirect_to admins_event_sponsors_path(@event)
  end

  def destroy
    sponsor = Institution.find(params[:id])
    @event.sponsors.destroy(sponsor)
    redirect_to admins_event_sponsors_path(@event)
  end

  protected

  def set_event
    @event = Event.find(params[:event_id])
  end

  def load_sponsors
    @institutions = Institution.where.not(id: @event.sponsors.pluck(:id))
  end
end
