class Admins::SectionsController < Admins::BaseController
  before_action :set_resource_name, only: [:create, :update, :destroy]
  before_action :set_event
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  add_breadcrumb I18n.t('breadcrumbs.action.index',
                        resource_name: I18n.t('activerecord.models.event.other')),
                 :admins_events_path, except: :destroy

  before_action :set_event_breadcrumb, except: :destroy

  add_breadcrumb I18n.t('breadcrumbs.action.index',
                        resource_name: I18n.t('activerecord.models.section.other')),
                 :admins_event_sections_path, except: :destroy

  add_breadcrumb I18n.t('breadcrumbs.action.new.f',
                        resource_name: I18n.t('activerecord.models.section.one')),
                 :new_admins_event_section_path, only: [:new, :create]

  add_breadcrumb I18n.t('breadcrumbs.action.edit',
                        resource_name: I18n.t('activerecord.models.section.one')),
                 :edit_admins_event_section_path, only: [:edit, :update]

  add_breadcrumb I18n.t('breadcrumbs.action.show',
                        resource_name: I18n.t('activerecord.models.section.one')),
                 :admins_event_section_path, only: [:show]

  def index
    @sections = @event.sections.order(position: :asc)
  end

  def new
    @section = @event.sections.new
  end

  def create
    options = {
      redirect_to: :new, path: admins_event_sections_path,
      action: 'flash.actions.create.f', model_name: @resource_name
    }
    @section = @event.sections.new(section_params)
    action_success? @section.save, options
  end

  def show; end

  def edit; end

  def update
    options = {
      redirect_to: :edit,
      path: admins_event_section_path(@event, @section),
      action: 'flash.actions.update.f',
      model_name: @resource_name
    }
    action_success? @section.update(section_params), options
  end

  def destroy
    @section.destroy
    flash[:success] = t('flash.actions.destroy.f', resource_name: @resource_name)

    redirect_to admins_event_sections_path
  end

  def sort
    params[:section].each_with_index do |id, position|
      @event.sections.find(id).update_attribute(:position, position + 1)
    end

    head :accepted
  end

  private

  def section_params
    params.require(:section).permit(
      :title, :status, :alternative_content_md,
      :icon, :content_md
    )
  end

  def set_resource_name
    @resource_name = Section.model_name.human
  end

  def set_section
    @section = @event.sections.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_breadcrumb
    path = admins_event_path(@event)
    name = "#{I18n.t('activerecord.models.event.one')} ##{@event.id}"
    add_breadcrumb I18n.t('breadcrumbs.action.index', resource_name: name),
                   path, except: :destroy
  end
end
