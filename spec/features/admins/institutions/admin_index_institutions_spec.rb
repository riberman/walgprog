require 'rails_helper'

describe 'Institution:index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:institution) { create(:institution) }
  # let(:institutions) { create_list(:institution, 2) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_institutions_path
  end

  it 'index - show all institutions' do
    expect(page).to have_content(institution.name)
    expect(page).to have_content(institution.acronym)
    expect(page).to have_content(institution.city.name)
    expect(page).to have_content(institution.city.state.acronym)
    expect(page).to have_link(href: edit_admins_institution_path(institution))
    destroy_link = "a[href='#{admins_institution_path(institution)}'][data-method='delete']"
    expect(page).to have_css(destroy_link)
  end
end
