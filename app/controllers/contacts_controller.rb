class ContactsController < ApplicationController
  before_action :set_contact, only: [:unregister, :update, :edit, :confirm_unregister]

  def edit
    if @contact.valid_token(params)
      render :edit
    else
      flash[:error] = I18n.t('flash.actions.errors')
    end
  end

  def unregister
    if @contact.update_by_token_to_unregister(params)
      render :unregistered
    else
      redirect_to admins_institution_path
    end
  end

  def update
    render @contact.update_by_token(params, params_contact)
  end

  def confirm_unregister; end

  def unregistered; end

  def updated; end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def params_contact
    params.require(:contact).permit(:name, :email, :phone, :institution_id)
  end
end
