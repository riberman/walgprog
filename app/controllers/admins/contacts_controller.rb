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
    success_action? @contact.save, :new,
                    t('flash.actions.update.m', resource_name: t('activerecord.models.contact.one'))
  end

  def show; end

  def edit; end

  def update
    success_action? @contact.update(params_contact), :edit,
                    t('flash.actions.create.m', resource_name: t('activerecord.models.contact.one'))
  end

  def destroy
    contact_name = @contact.name
    if @contact.destroy
      redirect_to admins_contacts_path,
                  notice: t('flash.actions.destroy.m', resource_name: contact_name)
    else
      render :index
    end
  end

  private

  def success_action?(result, view, message)
    if result
      redirect_to admins_contacts_path, notice: message
    else
      render view
    end
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def params_contact
    params.require(:contact).permit(:name, :email, :phone?, :institution_id)
  end
end
