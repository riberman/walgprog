# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def welcome
    @contact = Contact.first || FactoryBot.create(:contact)
    @contact.generate_update_token
    @contact.generate_unregister_token

    ContactMailer.with(contact: @contact).welcome
  end

  def success_update
    @contact = Contact.first || FactoryBot.create(:contact)

    ContactMailer.with(contact: @contact).success_update
  end
end
