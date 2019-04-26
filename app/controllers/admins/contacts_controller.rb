class Admins::ContactsController < Admins::BaseController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.includes(:institution)
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params_contact)
    if @contact.save
      flash[:success] = t('flash.actions.create.m',
                          resource_name: t('activerecord.models.contact.one'))
      redirect_to admins_contacts_path
    else
      flash.now[:error] = flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @contact.update(params_contact)
      flash[:success] = I18n.t('flash.actions.update.m',
                               resource_name: t('activerecord.models.contact.one'))
      redirect_to admins_contacts_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
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
