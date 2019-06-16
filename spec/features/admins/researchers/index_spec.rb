require 'rails_helper'

describe 'Admins::Researchers::index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:researchers) { create_list(:researcher, 5) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_researchers_path
  end

  context 'with data' do
    it 'showed' do
      expect(page).to have_link(href: new_admins_researcher_path)

      within('table tbody') do
        researchers.each do |researcher|
          expect(page).to have_content(researcher.name)
          expect(page).to have_content(researcher.scholarity.name)
          expect(page).to have_content(researcher.institution.name)
          expect(page).to have_link(href: edit_admins_researcher_path(researcher))
          expect(page).to have_destroy_link(href: admins_researcher_path(researcher))
        end
      end
    end
  end

  context 'with links' do
    it { expect(page).to have_link(I18n.t('researchers.new'), href: new_admins_researcher_path) }
  end
end
