require 'rails_helper'

describe 'Researchers:show', type: :feature do
  let(:admin) { create(:admin) }
  let!(:researcher) { create(:researcher) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_researcher_path(researcher)
  end

  context 'with data' do
    it 'showed' do
      # expect(page).to have_text(researcher.name)
      # expect(page).to have_css("input[value=#{researcher.genre}]")
      # expect(page).to have_css("input[value=#{researcher.institution.name}]", :exact)
      # expect(page).to have_css("input[value=#{researcher.scholarity.name}]")
    end
  end

  context 'with links' do
    it do
      expect(page).to have_link(I18n.t('helpers.edit'),
                                href: edit_admins_researcher_path(researcher))
    end
    it { expect(page).to have_link(I18n.t('helpers.back'), href: admins_researchers_path) }
  end
end
