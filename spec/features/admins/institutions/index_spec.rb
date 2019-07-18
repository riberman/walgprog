require 'rails_helper'

describe 'Admins::Institution::index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:institutions) { create_list(:institution, 3) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_institutions_path
  end

  context 'with data' do
    let(:unapproved) { build(:institution, :unapproved) }

    it 'showed only approved' do
      institutions.each do |institution|
        expect(page).to have_content(institution.name)
        expect(page).to have_content(institution.acronym)
        expect(page).to have_content(institution.city.name)
        expect(page).to have_content(institution.city.state.acronym)

        expect(page).to have_link(href: edit_admins_institution_path(institution))
        expect(page).to have_destroy_link(href: admins_institution_path(institution))
      end
    end
  end

  context 'with links' do
    it { expect(page).to have_link(I18n.t('institutions.new'), href: new_admins_institution_path) }
  end
end
