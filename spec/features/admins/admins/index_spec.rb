require 'rails_helper'

describe 'Admins::Admin::index', type: :feature do
  let!(:administrators) { create_list(:admin, 2, :administrator) }
  let!(:collaborators) { create_list(:admin, 2, :collaborator) }

  describe 'administrator' do
    let(:administrator) { create(:admin, :administrator) }

    before(:each) do
      login_as(administrator, scope: :admin)
      visit admins_admins_path
    end

    context 'with data' do
      it 'showed' do
        admins = administrators + collaborators

        admins.each do |admin|
          expect(page).to have_content(admin.name)
          expect(page).to have_content(admin.email)

          registered_date = I18n.t('helpers.registered', date: I18n.l(admin.created_at,
                                                                      format: :short_date))
          expect(page).to have_content(registered_date)

          pt_br_user_type = I18n.t("enums.user_types.#{admin.user_type}")
          expect(page).to have_content(pt_br_user_type)

          expect(page).to have_link(href: edit_admins_admin_path(admin))
          expect(page).to have_destroy_link(href: admins_admin_path(admin))
        end
      end
    end

    context 'with links' do
      it { expect(page).to have_link(href: new_admins_admin_path) }
      it { expect(page).to have_link(I18n.t('admins.new'), href: new_admins_admin_path) }
    end
  end

  describe 'collaborator' do
    let(:collaborator) { create(:admin, :collaborator) }

    before(:each) do
      login_as(collaborator, scope: :admin)
      visit admins_admins_path
    end

    context 'with data' do
      it 'showed' do
        admins = administrators + collaborators

        admins.each do |admin|
          expect(page).to have_content(admin.name)
          expect(page).to have_content(admin.email)

          registered_date = I18n.t('helpers.registered', date: I18n.l(admin.created_at,
                                                                      format: :short_date))
          expect(page).to have_content(registered_date)

          pt_br_user_type = I18n.t("enums.user_types.#{admin.user_type}")
          expect(page).to have_content(pt_br_user_type)

          expect(page).not_to have_link(href: edit_admins_admin_path(admin))
          expect(page).not_to have_destroy_link(href: admins_admin_path(admin))
        end
      end
    end

    context 'without links' do
      it { expect(page).not_to have_link(href: new_admins_admin_path) }
      it { expect(page).not_to have_link(I18n.t('admins.new'), href: new_admins_admin_path) }
    end
  end
end
