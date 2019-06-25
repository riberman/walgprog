class ContactsController < ApplicationController

  before_action :set_contact, only: [:unregister, :update, :edit]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.exists_email(@contact.email)
      @contact = Contact.where(email: @contact.email).first
      @contact.send_update_data_token
      ContactMailer.with(contact: @contact).update_email.deliver_later
      flash[:error] = 'Você já possui cadastro, verifique seu e-mail para atualizar seus dados.'
      redirect_to new_contact_path
    else
      if @contact.save
        ContactMailer.with(contact: @contact).welcome_email.deliver_later
        flash[:success] = t('flash.actions.create.m', resource_name: Contact.model_name.human)
        redirect_to new_contact_path
      else
        flash.now[:error] = I18n.t('flash.actions.errors')
        render :new
      end
    end
  end

  def edit;
  end

  def update;
  end

  def unregister
    if params[:unregister_token].eql? @contact.unregister_token
      if @contact.update(unregistered: true)
        ContactMailer.with(contact: @contact).unregister_email.deliver_later
        flash[:success] = 'E-mail descadastrado.'
        redirect_to new_contact_path
      end
    else
      flash[:error] = 'Seu token não é válido.'
      redirect_to new_contact_path
    end
  end

  protected

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :institution_id)
  end

end
