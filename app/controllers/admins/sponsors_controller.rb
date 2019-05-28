class Admins::SponsorsController < Admins::BaseController
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

  # before_action :set_resource_name, only: [:create, :update, :destroy]
  # before_action :set_sponsor_event, only: [:edit, :update, :destroy]
  #
  # add_breadcrumb I18n.t('breadcrumbs.action.add',
  #                       resource_name: I18n.t('activerecord.models.sponsor_event.one')),
  #                :new_admins_sponsor_event_path, only: [:new, :create]
  #
  # def new
  #   @sponsor_event = SponsorEvent.new
  #   add_event(params[:event])
  #   add_institution(params[:institution])
  # end
  #
  # def create
  #   @sponsor_event = SponsorEvent.new(sponsor_event_params)
  #   if @sponsor_event.save
  #     flash[:success] = t('flash.actions.add.m', resource_name: @resource_name)
  #     redirect_to admins_event_path(@sponsor_event.event)
  #   else
  #     flash.now[:error] = I18n.t('flash.actions.errors')
  #     render 'new'
  #   end
  # end
  #
  # def show; end
  #
  # def edit; end
  #
  # def update
  #   if @sponsor_event.update(sponsor_event_params)
  #     flash[:success] = t('flash.actions.update.m', resource_name: @resource_name)
  #     redirect_to admins_event_path(@sponsor_event.event)
  #   else
  #     flash.now[:error] = I18n.t('flash.actions.errors')
  #     render 'edit'
  #   end
  # end
  #
  # def destroy
  #   @event = @sponsor_event.event
  #   @sponsor_event.destroy
  #
  #   flash[:success] = t('flash.actions.destroy.m', resource_name: @resource_name)
  #   redirect_to admins_event_path(@event)
  # end
  #
  # def sponsor_event_params
  #   params.require(:sponsor_event).permit(:event_id,
  #                                         :institution_id)
  # end
  #
  # def set_resource_name
  #   @resource_name = SponsorEvent.model_name.human
  # end
  #
  # def set_sponsor_event
  #   @sponsor_event = SponsorEvent.find(params[:id])
  # end
  #
  # def add_event(event_id)
  #   return unless event_id
  #
  #   @event = Event.find(event_id)
  #   @sponsor_event.event = @event if @event
  # end
  #
  # def add_institution(institution_id)
  #   return unless institution_id
  #
  #   @institution = Institution.find(institution_id)
  #   @sponsor_event.institution = @institution if @institution
  # end
end
