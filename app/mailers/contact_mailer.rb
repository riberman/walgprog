class ContactMailer < ApplicationMailer

  def welcome_email
    @contact = params[:contact]
    email_with_name = %("#{@contact.name}" <#{@contact.email}>)
    mail(to: email_with_name, subject: 'Welcome to My Awesome Site')
  end

  def unregistered_contact
    @contact = params[:contact]
    email_with_name = %("#{@contact.name}" <#{@contact.email}>)
    mail(to: email_with_name, subject: 'Você foi Descadastrado')
  end

  def self_update_contact
    @contact = params[:contact]
    email_with_name = %("#{@contact.name}" <#{@contact.email}>)
    mail(to: email_with_name, subject: 'Você foi Atualizado')
  end
end

# settings app rails
# action mailer template define by user
