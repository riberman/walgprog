require 'rails_helper'

describe 'Admins::Institution::index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:institutions) { create_list(:institution, 3) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_institutions_path
  end

  it 'show all institutions' do
    expect(page).to have_link(href: new_admins_institution_path)

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
