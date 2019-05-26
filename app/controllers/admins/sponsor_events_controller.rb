class Admins::EventsController < Admins::BaseController
  before_action :set_resource_name, only: [:create, :update, :destroy]
  before_action :set_sponsor_event, only: [:edit, :update, :destroy]

  def new
    @sponsor_event = SponsorEvent.new
  end

  def create
    @sponsor_event = SponsorEvent.new(sponsor_event_params)
    if @sponsor_event.save
      flash[:success] = t('flash.actions.create.m', resource_name: @resource_name)
      redirect_to admins_institutions_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @sponsor_event.update event_params
      flash[:success] = t('flash.actions.update.m', resource_name: @resource_name)
      redirect_to admins_institutions_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render 'edit'
    end
  end

  def destroy
    @sponsor_event.destroy

    flash[:success] = t('flash.actions.destroy.m', resource_name: @resource_name)
    redirect_to admins_institutions_path
  end

  def sponsor_event_params
    params.require(:sponsor_event).permit(:event_id,
                                          :institution_id)
  end

  def set_resource_name
    @resource_name = SponsorEvent.model_name.human
  end

  def set_sponsor_event
    @sponsor_event = SponsorEvent.find(params[:id])
  end
end
