require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:user_type) }
    it { is_expected.to validate_presence_of(:password) }

    context 'when blank attributes' do
      admin = Admin.new
      it 'name message blank' do
        expect(admin).not_to be_valid
        expect(admin.errors[:name]).to include(I18n.t('errors.messages.blank'))
      end

      it 'email message blank' do
        expect(admin).not_to be_valid
        expect(admin.errors[:email]).to include(I18n.t('errors.messages.blank'))
      end

      it 'user_type message blank' do
        expect(admin).not_to be_valid
        expect(admin.errors[:user_type]).to include(I18n.t('errors.messages.blank'))
      end

      it 'password messgage blank' do
        expect(admin).not_to be_valid
        expect(admin.errors[:password]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context 'when user type' do
      let(:admin) { create(:admin) }

      it 'is admin' do
        expect(admin.admin?).to eq(true)
      end

      it 'is not admin' do
        admin.update(user_type: 'C')

        expect(admin.admin?).to eq(false)
      end
    end

    context 'when human user type' do
      let(:admin) { create(:admin) }

      it 'enum administrator' do
        enum_user_type = I18n.t("enums.user_types.#{admin.user_type}")
        expect(enum_user_type).to eq(I18n.t('enums.user_types.administrator'))
      end

      it 'enum collaborator' do
        admin.update(user_type: 'C')

        enum_user_type = I18n.t("enums.user_types.#{admin.user_type}")
        expect(enum_user_type).to eq(I18n.t('enums.user_types.collaborator'))
      end
    end
  end

  context 'when create and update admin' do
    let(:admin) { create(:admin) }

    it 'create valid' do
      expect(admin).to be_valid
    end

    it 'update with password valid' do
      admin.update(user_type: 'C')

      expect(admin).to be_valid
    end

    it 'update without password' do
      admin.update(user_type: 'A')

      expect(admin).to be_valid
    end

    it 'update with password confirmation error' do
      admin.update(password: '123456', password_confirmation: '')

      expect(admin).not_to be_valid
      expect(admin.errors[:password_confirmation]).to include('não é igual a Senha')
    end
  end
end
