require 'rails_helper'

describe 'Breadcrumbs', type: :feature do
  context 'verify presence' do
    let(:admin) { create(:admin) }

    before(:each) do
      login_as(admin, scope: :admin)
      visit edit_admin_registration_path
    end

    it "should have 3 li elements" do
      expect(find('ol')).to have_selector('li', count: 3)
    end

    it "should have text" do
      i = -1
      k = -1
      paths_text = [:root_path, :edit_admin_registration_path]
      breadcrumbs_text = [I18n.t('breadcrumbs.homepage'), "/", I18n.t('breadcrumbs.Admins.edit')]
      breadcrumbs = all('li').each { |li| li[:text] }
      paths = all('li a').each { |a| a[:href] }
      breadcrumbs.each { |l|
        messege =  l.text
        expect(messege).to have_content(breadcrumbs_text[i+=1])
        if breadcrumbs.count / 2 != 0
          expect(paths[k+=2]).to have_content(paths_text[k+=2])
        end
      }
    end
  end
end