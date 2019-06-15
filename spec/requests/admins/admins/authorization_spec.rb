require 'rails_helper'

describe 'Admins::Admin::authorization', type: :request do
  let(:collaborator) { create(:admin, :collaborator) }

  before(:each) do
    login_as(collaborator, scope: :admin)
  end

  describe 'not authorized' do
    it 'send a post to create an admin' do
      post '/admins/admins'

      expect(response).to redirect_to admins_admins_path
      follow_redirect!
      expect(response.body).to include(I18n.t('flash.not_authorized'))
    end

    it 'send a post to edit and admin' do
      admin = create(:admin)
      patch "/admins/admins/#{admin.id}"

      expect(response).to redirect_to admins_admins_path
      follow_redirect!
      expect(response.body).to include(I18n.t('flash.not_authorized'))
    end
  end
end
