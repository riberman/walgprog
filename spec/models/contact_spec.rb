require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }

    context 'when email' do
      it { is_expected.to allow_value('email@addresse.foo').for(:email) }
      it { is_expected.to allow_value('email@addresse.foo.foo').for(:email) }
      it { is_expected.not_to allow_value('foo').for(:email) }
    end

    context 'when phone' do
      it { is_expected.to allow_value('(11) 3333-4444').for(:phone) }
      it { is_expected.to allow_value('(11) 33333-4444').for(:phone) }
      it { is_expected.not_to allow_value('11 3333-4444').for(:phone) }
      it { is_expected.not_to allow_value('11 33333-4444').for(:phone) }
      it { is_expected.not_to allow_value('113333-4444').for(:phone) }
      it { is_expected.not_to allow_value('1133333-4444').for(:phone) }
      it { is_expected.not_to allow_value('1133334444').for(:phone) }
      it { is_expected.not_to allow_value('11333334444').for(:phone) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:institution) }
  end

  describe '#email_with_name' do
    let(:contact) { build(:contact) }

    it { expect(contact.email_with_name).to eq(%("#{contact.name}" <#{contact.email}>)) }
  end

  describe 'send email' do
    let(:contact) { create(:contact) }

    before(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it '#send_welcome_email' do
      expect { contact.send_welcome_email }.to change {
        ActionMailer::Base.deliveries.count
      }.by(1)

      update_token = contact.update_token
      unregister_token = contact.unregister_token

      expect(contact.valid_update_token?(update_token)).to be true
      expect(contact.valid_unregister_token?(unregister_token)).to be true
    end

    it '#send_updated_email' do
      expect { contact.send_updated_email }.to change {
        ActionMailer::Base.deliveries.count
      }.by(1)
    end

    it '#send_update_email' do
      expect { contact.send_update_email }.to change {
        ActionMailer::Base.deliveries.count
      }.by(1)
    end

    it '#send_confirmation_email' do
      expect { contact.send_confirmation_email }.to change {
        ActionMailer::Base.deliveries.count
      }.by(1)
    end
  end

  context 'with token' do
    let(:contact) { create(:contact) }

    it 'update' do
      token = contact.generate_update_token

      expect(contact.valid_update_token?(token)).to be true
      contact.invalidate_update_token
      expect(contact.valid_update_token?(token)).to be false
    end

    it 'unregister' do
      token = contact.generate_unregister_token

      expect(contact.valid_unregister_token?(token)).to be true
      contact.invalidate_unregister_token
      expect(contact.valid_unregister_token?(token)).to be false
    end

    it 'confirmation' do
      token = contact.generate_confirmation_token

      expect(contact.valid_confirmation_token?(token)).to be true
      contact.invalidate_confirmation_token
      expect(contact.valid_confirmation_token?(token)).to be false
    end
  end

  context 'with register and unregistered' do
    it 'set as register' do
      contact = create(:contact, unregistered: true)
      contact.set_as_registered

      expect(contact.unregistered?).to be false
    end

    it 'set as unregistered' do
      contact = create(:contact, unregistered: false)
      contact.set_as_unregistered

      expect(contact.unregistered?).to be true
    end
  end

  describe 'confirmation' do
    it '#confirmed must return false' do
      contact = build(:contact, confirmed_at: nil)
      expect(contact.confirmed?).to be false
    end

    it '#confirmed must return true' do
      contact = build(:contact)
      expect(contact.confirmed?).to be true
    end

    it '#confirm' do
      contact = create(:contact, confirmed_at: nil)
      contact.confirm
      expect(contact.confirmed?).to be true
      expect(contact.valid_confirmation_token?(contact.confirmation_token)).to be false
    end
  end
end
