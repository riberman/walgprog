class ContactMailer < ApplicationMailer

  def welcome_email
    @contact = params[:contact]
    mail(to: @contact.email, subject: 'Welcome to My Awesome Site')
  end

end
