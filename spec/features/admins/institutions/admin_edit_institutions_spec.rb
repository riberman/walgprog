require 'rails_helper'

describe 'Institution:edit', type: :feature do
  let(:institution) { create(:institution) }
  let(:admin) { create(:admin) }
  let!(:city) { create_list(:city, 5).sample }

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_institution_path
  end
end
