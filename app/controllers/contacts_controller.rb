class ContactsController < ApplicationController
  layout 'layouts/contacts/update_unregister'

  before_action :set_contact, except: [:feedback, :new, :create]
  before_action :verify_update_token, only: [:edit, :update]
  before_action :verify_unregister_token, only: [:unregister]
  before_action :contact_exists, only: [:create]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params_contact)
    if @contact.save
      @contact.send_confirmation_email
      flash[:success] = I18n.t('contacts.messages.created', name: @contact.name)
      redirect_to contact_feedback_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @contact.update(params_contact)
      flash[:success] = I18n.t('contacts.messages.updated', name: @contact.name)
      @contact.send_updated_email
      @contact.invalidate_update_token
      redirect_to contact_feedback_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def unregister
    if @contact.set_as_unregistered
      @contact.invalidate_unregister_token
      flash[:success] = I18n.t('contacts.messages.unregistered', name: @contact.name)
    end

    redirect_to contact_feedback_path
  end

  def registration_confirmation
    if @contact.valid_confirmation_token?(params[:token])
      @contact.confirm
      flash[:success] = I18n.t('contacts.messages.confirmed', name: @contact.name)
      redirect_to contact_feedback_path
    else
      redirect_to_when_invalid_token
    end
  end

  def unregister_confirmation; end

  def feedback; end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def params_contact
    params.require(:contact).permit(:name, :email, :phone, :institution_id)
          .to_h.reverse_merge(unregistered: false)
  end

  def verify_update_token
    return if @contact.valid_update_token?(params[:token])

    redirect_to_when_invalid_token
  end

  def verify_unregister_token
    return if @contact.valid_unregister_token?(params[:token])

    redirect_to_when_invalid_token
  end

  def redirect_to_when_invalid_token
    flash[:error] = I18n.t('contacts.messages.invalid_token')
    redirect_to contact_feedback_path
  end

  def contact_exists
    contact = Contact.find_by email: params_contact[:email]
    return unless contact

    if contact.confirmed?
      contact.send_update_email
      flash[:success] = I18n.t('contacts.messages.unregistered_create', name: contact.name)
    else
      contact.send_confirmation_email
      flash[:notice] = I18n.t('contacts.messages.not_confirmed', name: contact.name)
    end

    redirect_to contact_feedback_path
  end
end
