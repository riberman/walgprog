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

  describe 'send email' do
    context 'when contact is created' do
      let(:contact) { create(:contact) }

      it {
        contact.send_welcome_email
        expect { contact.send_welcome_email }.to change {
          ActionMailer::Base.deliveries.count
        }.by(1)
      }
    end

    context 'when contact is updated with successfully' do
      let(:contact) { create(:contact) }

      it {
        contact.send_self_update
        expect { contact.send_self_update }.to change {
          ActionMailer::Base.deliveries.count
        }.by(1)
      }
    end

    context 'when contact is unregistered' do
      let(:contact) { create(:contact) }

      it {
        contact.send_self_unregister
        expect { contact.send_self_unregister }.to change {
          ActionMailer::Base.deliveries.count
        }.by(1)
      }
    end
  end

  describe 'checking tokens' do
    context 'with unregistered token' do
      let(:contact) { create(:contact) }

      it {
        contact.generate_token(:unregister_token)
        expect(contact).to be_valid
      }
    end

    context 'with update token' do
      let(:contact) { create(:contact) }

      it {
        contact.generate_token(:update_data_token)
        expect(contact).to be_valid
      }
    end

    context 'with update_by_token_to_unregister successfully' do
      let(:contact) { create(:contact) }

      it {
        params = { id: contact.id, token: contact.unregister_token }

        expect(contact.update_by_token_to_unregister(params)).to eq(true)
      }
    end

    context 'with update_by_token_to_unregister failure' do
      let(:contact) { create(:contact) }

      it {
        params = { token: 'web5developer' }

        expect(contact.update_by_token_to_unregister(params)).to eq(false)
      }
    end

    context 'with equal_token successfully' do
      let(:contact) { create(:contact) }

      it {
        param = { token: contact.unregister_token }

        expect(contact.equal_token(param)).to eq(true)
      }
    end

    context 'with equal_token failure' do
      let(:contact) { create(:contact) }

      it {
        param = { token: 'web5developer' }

        expect(contact.equal_token(param)).to eq(false)
      }
    end

    context 'with valid_token successfully' do
      let(:contact) { create(:contact) }

      it {
        param = { token: contact.update_data_token }

        expect(contact.valid_token(param)).to eq(true)
      }
    end

    context 'with valid_token failure' do
      let(:contact) { create(:contact) }

      it {
        param = { token: 'web5developer' }

        expect(contact.valid_token(param)).to eq(false)
      }
    end

    context 'with invalidate_token' do
      let(:contact) { create(:contact) }

      it {
        contact.invalidate_token
        expect(contact).to be_valid
      }
    end
  end
end
