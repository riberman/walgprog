require 'rails_helper'

describe 'Breadcrumbs', type: :feature do
  context 'with the correct' do
    let(:admin) { create(:admin) }

    before(:each) do
      login_as(admin, scope: :admin)
      visit edit_admin_registration_path
    end

    it 'text' do
      breadcrumbs_text = [I18n.t('breadcrumbs.homepage'),
                          '/',
                          I18n.t('breadcrumbs.action.edit',
                                 resource_name: 'Administrador')]
      all('li').each_with_index do |li, index|
        expect(li.text).to have_content(breadcrumbs_text[index])
      end
    end

    it 'url' do
      expected_paths = ['/admins']
      all('li a').each_with_index do |a, index|
        puts a[:href] == expected_paths[index]
        expect(a[:href]).to have_content(expected_paths[index])
      end
    end
  end
end
