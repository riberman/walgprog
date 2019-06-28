class Admins::SectionsController < Admins::BaseController
  before_action :set_resource_name, only: [:create, :update, :destroy]
  before_action :set_section, only: [:show, :edit, :update, :destroy]
  before_action :set_event
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
    @sections = @event.sections.order(index: :desc)
  end

  def new
    @section = Section.new
    max_index
  end

  def create
    options = {
      redirect_to: :new,
      path: admins_event_sections_path,
      action: 'flash.actions.create.f',
      model_name: @resource_name
    }
    @section = @event.sections.build(section_params)
    action_success? @section.save, options
  end

  def show; end

  def edit; end

  def update
    options = {
      redirect_to: :edit,
      path: admins_event_sections_path,
      action: 'flash.actions.update.f',
      model_name: @resource_name
    }
    action_success? @section.update(section_params), options
  end

  def destroy
    begin
      @section.destroy
      flash[:success] = t('flash.actions.destroy.f', resource_name: @resource_name)
    rescue RuntimeError
      flash[:error] = t('sections.error.be_deleted')
    end
    redirect_to admins_event_sections_path
  end

  def update_index
    respond_to do |format|
      sections = params[:list]
      if sections.blank?
        response_to(format, 'sections.error.error_order', :unprocessable_entity)
      else
        update_position_section sections
        response_to(format, 'sections.saved_order', :accepted)
      end
    end
  end

  private

  def update_position_section(list)
    list.each do |section|
      @section = Section.find(section['id'])
      @section.index = section['index']
      @section.save
    end
  end

  def response_to(format, message, status)
    format.json { render json: { message: t(message) }, status: status }
  end

  def section_params
    params.require(:section).permit(
      :title, :status, :alternative_text,
      :icon, :index, :event_id, :content_markdown
    )
  end

  def set_resource_name
    @resource_name = Section.model_name.human
  end

  def set_section
    @section = Section.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def max_index
    @section.index = @event.sections.count + 1 if @section.new_record?
  end

  def set_event_breadcrumb
    path = admins_event_path(@event)
    add_breadcrumb I18n.t('breadcrumbs.action.index',
                          resource_name: I18n.t('activerecord.models.event.one')),
                   path, except: :destroy
  end
end
