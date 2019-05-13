require 'rails_helper'

describe 'Breadcrumbs', type: :feature do
  context 'with the correct' do
    let(:admin) { create(:admin) }

    before(:each) do
      login_as(admin, scope: :admin)
      visit edit_admin_registration_path
    end

    it 'text' do
      i = 0
      breadcrumbs_text = [I18n.t('breadcrumbs.homepage'), '/', I18n.t('breadcrumbs.Admins.edit')]
      all('li').each do |li|
        puts li.text
        expect(li.text).to have_content(breadcrumbs_text[i])
        i += 1
      end
    end

    it 'url' do
      expected_paths = ['/admins']
      i = 0
      all('li a').each do |a|
        puts a[:href] == expected_paths[i]
        expect(a[:href]).to have_content(expected_paths[i])
        i += 1
      end
    end
  end
end
