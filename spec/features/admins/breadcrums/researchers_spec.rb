require 'rails_helper'

describe 'Admins::Researcher::Breadcrumbs', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Researcher.model_name.human }
  let(:resource_name_plural) { Researcher.model_name.human count: 2 }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  context 'when index' do
    let(:breadcrumbs) do
      [
        { text: text_for_home, path: admins_root_path },
        { text: text_for_index, path: admins_researchers_path }
      ]
    end
  end
end
