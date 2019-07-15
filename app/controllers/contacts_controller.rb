class ContactsController < ApplicationController
  before_action :set_contact, except: [:feedback]

  layout 'layouts/contacts/update_unregister'

  def edit
    if @contact.valid_update_token?(params[:token])
      render :edit
    else
      flash[:error] = I18n.t('contacts.messages.invalid_token')
      redirect_to contact_feedback_path
    end
  end

  def update
    if @contact.update_with_update_token(params[:token], params_contact)
      flash[:success] = I18n.t('contacts.messages.success_update', name: @contact.name)
      @contact.send_success_update_email
      redirect_to contact_feedback_path
    else
      update_errors
    end
  end

  def unregister
    if @contact.update_with_unregister_token(params[:token], unregistered: true)
      flash[:success] = I18n.t('contacts.messages.success_unregister', name: @contact.name)
    else
      flash[:error] = I18n.t('contacts.messages.invalid_token')
    end
    redirect_to contact_feedback_path
  end

  def feedback; end

  def unregister_confirmation; end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def params_contact
    params.require(:contact).permit(:name, :email, :phone, :institution_id)
  end

  def update_errors
    if @contact.errors[:token].empty?
      flash[:error] = I18n.t('flash.actions.errors')
      render :edit
    else
      flash[:error] = I18n.t('contacts.messages.invalid_token')
      redirect_to contact_feedback_path
    end
  end
end
