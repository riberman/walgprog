require 'rails_helper'

describe 'Admins::Admin::index', type: :feature do
  let(:admin) { create(:admin) }
  let!(:admins) { create_list(:admin, 3) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit admins_admins_path
  end

  context 'with data' do
    it 'showed' do
      expect(page).to have_link(href: new_admins_admin_path)

      admins.each do |admin|
        expect(page).to have_content(admin.name)
        expect(page).to have_content(admin.email)
        pt_br_user_type = I18n.t("enums.user_types.#{admin.user_type}")
        expect(page).to have_content(pt_br_user_type)
        expect(page).to have_link(href: edit_admins_admin_path(admin))
        expect(page).to have_destroy_link(href: admins_admin_path(admin))
      end
    end
  end

  context 'with links' do
    it { expect(page).to have_link(I18n.t('admins.new'), href: new_admins_admin_path) }
  end

  context 'with collaborator' do
    let(:admin) { create(:admin, user_type: 'C') }
    let!(:admins) { create_list(:admin, 3) }

    before(:each) do
      login_as(admin, scope: :admin)
      visit admins_admins_path
    end

    context 'with data' do
      it 'showed' do
        expect(page).not_to have_link(href: new_admins_admin_path)

        admins.each do |admin|
          expect(page).to have_content(admin.name)
          expect(page).to have_content(admin.email)
          pt_br_user_type = I18n.t("enums.user_types.#{admin.user_type}")
          expect(page).to have_content(pt_br_user_type)
          expect(page).not_to have_link(href: edit_admins_admin_path(admin))
          expect(page).not_to have_destroy_link(href: admins_admin_path(admin))
        end
      end
    end

    context 'with no links' do
      it { expect(page).not_to have_link(I18n.t('admins.new'), href: new_admins_admin_path) }
    end

    context 'when user is collaborator' do
      let(:admin) { create(:admin, user_type: 'C') }

      before(:each) do
        login_as(admin, scope: :admin)
        visit new_admins_admin_path
      end

      it 'redirect to login page' do
        expect(page).to have_current_path admins_admins_path
        expect(page).to have_flash('danger', text: I18n.t('flash.not_authorized'))
      end
    end
  end
end
