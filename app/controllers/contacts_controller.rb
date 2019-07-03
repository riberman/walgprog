class ContactsController < ApplicationController
  before_action :set_contact, only: [:unregister, :update, :edit, :confirm_unregister]

  layout 'layouts/contact'

  def edit
    if @contact.valid_token(params)
      render :edit
    else
      redirect_to contact_time_exceeded_path
    end
  end

  def unregister
    if @contact.update_by_token_to_unregister(params)
      redirect_to contact_unregistered_path
    else
      redirect_to contact_already_unregistered_path
    end
  end

  def update
    if @contact.update_by_token(params_contact)
      flash[:success] = I18n.t('flash.actions.update.m',
                               resource_name: I18n.t('activerecord.models.contact.one'))
      redirect_to contact_updated_path
    else
      flash[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def confirm_unregister; end

  def unregistered; end

  def updated; end

  def already_unregistered; end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def params_contact
    params.require(:contact).permit(:name, :email, :phone, :institution_id)
  end
end
