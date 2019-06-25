class ContactMailer < ApplicationMailer
  before_action :load_contact

  def welcome_email
    mail(to: @contact.email, subject: 'Bem-Vindo(a) ao WAlgProg')
  end

  def unregister_email
    mail(to: @contact.email, subject: 'Descadastro de e-mail - WAlgProg')
  end

  def update_email
    mail(to: @contact.email, subject: 'Atualização de Cadastro - WAlgProg')
  end

  def load_contact
    @contact = params[:contact]
  end

end
