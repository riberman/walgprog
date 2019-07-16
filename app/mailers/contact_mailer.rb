class ContactMailer < ApplicationMailer
  def welcome
    @contact = params[:contact]
    mail(to: @contact.email_with_name, subject: I18n.t('mail.welcome_email.subject'))
  end

  def confirmation
    @contact = params[:contact]
    mail(to: @contact.email_with_name, subject: I18n.t('mail.confirmation.subject'))
  end

  def update
    @contact = params[:contact]
    mail(to: @contact.email_with_name, subject: I18n.t('mail.update.subject'))
  end

  def updated
    @contact = params[:contact]
    mail(to: @contact.email_with_name, subject: I18n.t('mail.updated.subject'))
  end
end

# settings app rails
# action mailer template define by user
