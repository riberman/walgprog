class ContactController < ApplicationController

  before_action :set_contact, only: [:unregister, :update, :edit]

  def edit
    final_valid_time = (@contact.update_data_send_at + 2.hours)
    if (params[:token].eql? (@contact.update_data_token)) && (final_valid_time > Time.zone.now)
        render 'public/contact/edit'
    end
  end

  def unregister
      if params[:token].eql? @contact.unregister_token
        if Contact.update(params[:id], unregistered: true)
          ContactMailer.with(contact: @contact).unregistered_contact.deliver
          render 'public/contact/contact_unregistered'
        end
      else
        # apenas para teste
        redirect_to admins_institutions_path
      end
  end

  def update
    final_valid_time = (@contact.update_data_send_at + 2.hours)

    if final_valid_time > Time.zone.now
      if @contact.update(params_contact)
        ContactMailer.with(contact: @contact).self_update_contact.deliver
        render 'public/contact/update_success'
      else
        render 'edit'
      end
    else
      render 'public/contact/time_exceeded'
    end
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def params_contact
    params.require(:contact).permit(:name, :email, :phone, :institution_id)
  end
end