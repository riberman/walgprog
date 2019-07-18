# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def initialize(params = {})
    super(params)
    @contact = Contact.first || FactoryBot.create(:contact)
  end

  def welcome
    @contact.generate_update_token
    @contact.generate_unregister_token

    ContactMailer.with(contact: @contact).welcome
  end

  def updated
    ContactMailer.with(contact: @contact).updated
  end

  def update
    @contact.generate_update_token
    ContactMailer.with(contact: @contact).update
  end

  def confirmation
    @contact.generate_confirmation_token
    ContactMailer.with(contact: @contact).confirmation
  end
end
