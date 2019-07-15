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

    it '#send_success_update_email' do
      expect { contact.send_success_update_email }.to change {
        ActionMailer::Base.deliveries.count
      }.by(1)
    end
  end

  context 'with token' do
    let(:contact) { create(:contact) }

    it 'update with token' do
      params = attributes_for(:contact)
      token = contact.generate_update_token

      expect(contact.update_with_update_token(token, params)).to be true
      expect(contact.valid_update_token?(token)).to be false
      expect(contact.update_with_update_token(token, params)).to be false
    end

    it 'unregister with token' do
      params = { unregistered: true }
      token = contact.generate_unregister_token

      contact.update_with_unregister_token(token, params)

      expect(contact.unregistered?).to be true
      expect(contact.valid_unregister_token?(token)).to be false
      expect(contact.update_with_unregister_token(token, params)).to be false
    end
  end
end
