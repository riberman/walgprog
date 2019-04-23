class Admins::ContactsController < Admins::BaseController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params_contact)
    if @contact.save
      flash[:success] = I18n.t('flash.actions.create.m', resource_name: t('activerecord.models.contact.one'))
      redirect_to admins_contacts_path
    else
      flash.now[:error] = flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @contact.update_attributes(params_contact)
      flash[:success] = I18n.t('flash.actions.update.m', resource_name: t('activerecord.models.contact.one'))
      redirect_to admins_contacts_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render edit_admin_contact_path
    end
  end

  def destroy
    contact_name = @contact.name
    if @contact.destroy
      flash[:success] = I18n.t('flash.actions.destroy.m', resource_name: contact_name)
      redirect_to admins_contacts_path
    else
      render :index
    end
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def params_contact
    params.require(:contact).permit(:name, :email, :phone?, :institution_id)
  end
end
