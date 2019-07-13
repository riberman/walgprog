class Admins::ContactsController < Admins::BaseController
  add_breadcrumb I18n.t('breadcrumbs.action.index',
                        resource_name: I18n.t('activerecord.models.contact.other')),
                 :admins_contacts_path, except: :destroy

  add_breadcrumb I18n.t('breadcrumbs.action.new.m',
                        resource_name: I18n.t('activerecord.models.contact.one')),
                 :new_admins_contact_path, only: [:new, :create]

  add_breadcrumb I18n.t('breadcrumbs.action.edit',
                        resource_name: I18n.t('activerecord.models.contact.one')),
                 :edit_admins_contact_path, only: [:edit, :update]

  add_breadcrumb I18n.t('breadcrumbs.action.show',
                        resource_name: I18n.t('activerecord.models.contact.one')),
                 :admins_contact_path, only: :show

  add_breadcrumb I18n.t('breadcrumbs.action.unregistered',
                        resource_name: I18n.t('activerecord.models.contact.other')),
                 :admins_contacts_unregistered_path, only: :unregistered

  add_breadcrumb I18n.t('breadcrumbs.action.registered',
                        resource_name: I18n.t('activerecord.models.contact.other')),
                 :admins_contacts_registered_path, only: :registered

  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.includes(:institution).order('contacts.name ASC')
  end

  def unregistered
    @contacts = Contact.where(unregistered: true).includes(:institution).order('contacts.name ASC')
    render :index
  end

  def registered
    @contacts = Contact.where(unregistered: false).includes(:institution).order('contacts.name ASC')
    render :index
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params_contact)
    @contact.assign_tokens
    options = {
      redirect_to: :new,
      path: admins_contacts_path,
      action: 'flash.actions.create.m',
      model_name: t('activerecord.models.contact.one')
    }
    action_success? @contact.save, options
  end

  def show; end

  def edit; end

  def update
    options = {
      redirect_to: :edit,
      path: admins_contacts_path,
      action: 'flash.actions.update.m',
      model_name: t('activerecord.models.contact.one')
    }
    action_success? @contact.update(params_contact), options
  end

  def destroy
    contact_name = @contact.name

    @contact.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m', resource_name: contact_name)
    redirect_to admins_contacts_path
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def params_contact
    params.require(:contact).permit(:name, :email, :phone, :institution_id)
  end
end
