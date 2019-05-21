require 'rails_helper'

describe 'Researchers:show', type: :feature do
  let(:admin) { create(:admin) }
  let(:researcher) { create(:researcher) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_researcher_path(researcher)
  end

  it 'show researcher' do
    expect(page).to have_css("input[value=#{researcher.name}]")
    expect(page).to have_css("input[value=#{researcher.title}]")
    expect(page).to have_css("input[value=#{researcher.academic_title}]")
    # expect(page).to have_css("input[value=#{researcher.institution.name}]")
    # expect(page).to have_xpath("//img[@src = #{researcher.image}]")
    expect(page).to have_css("input[value=#{researcher.genre}]")
    expect(page).to have_link(href: edit_admins_researcher_path(researcher))
    expect(page).to have_link(href: admins_researchers_path)
  end
end
