class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.with(contact: @contact).welcome_email.deliver_later
      flash[:success] = t('flash.actions.create.m', resource_name: Contact.model_name.human)
      redirect_to new_contact_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def unregistered
    @contact = Contact.find(params[:id])
    @contact.unregistered
    flash[:success] = 'sucesso!'
    redirect_to root_path
  end

protected
  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :institution_id)
  end

end
