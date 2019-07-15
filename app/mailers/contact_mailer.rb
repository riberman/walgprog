class ContactMailer < ApplicationMailer
  def welcome
    @contact = params[:contact]
    mail(to: @contact.email_with_name, subject: I18n.t('mail.welcome_email.subject'))
  end

  def success_update
    @contact = params[:contact]
    mail(to: @contact.email_with_name, subject: I18n.t('mail.updated.subject'))
  end
end

# settings app rails
# action mailer template define by user
