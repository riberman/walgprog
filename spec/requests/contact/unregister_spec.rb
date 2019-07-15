require 'rails_helper'

describe 'Contact::unregister', type: :request do
  let(:contact) { create(:contact) }

  context 'when token is different' do
    it 'redirect to invalid token page' do
      token = 'df4d5f4d5d45fss5d4s5d4s5d45'
      patch contact_unregister_path(contact, token)

      expect(response).to redirect_to contact_feedback_path

      follow_redirect!
      expect(response.body).to include(I18n.t('contacts.messages.invalid_token'))
    end
  end
end
