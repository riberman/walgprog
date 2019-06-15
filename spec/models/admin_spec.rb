require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:user_type) }
  end

  describe '#user_type' do
    let(:admin) { build(:admin, :administrator) }

    it 'admistrator' do
      expect(admin.administrator?).to be true
      expect(admin.collaborator?).to be false
    end

    it 'collaborator' do
      admin.user_type = 'C'
      expect(admin.administrator?).to be false
      expect(admin.collaborator?).to be true
    end
  end

  describe '#update' do
    let(:admin) { create(:admin) }

    it 'with password update all attributes' do
      params = attributes_for(:admin, password: '123456', password_confirmation: '123456')

      admin.update(params)
      admin.reload

      expect(admin.valid_password?('123456')).to be true
    end

    it 'without password update attributes but keeep the same password' do
      params = { name: 'new name' }

      admin.update(params)
      admin.reload

      expect(admin.valid_password?('password')).to be true
      expect(admin.name).to eql('new name')
    end

    it 'with empty password update attributes but keeep the same password' do
      params = { name: 'new name', password: '', password_confirmation: '' }

      admin.update(params)
      admin.reload

      expect(admin.valid_password?('password')).to be true
      expect(admin.name).to eql('new name')
    end
  end

  describe '.user_types' do
    subject(:admin) { Admin.new }

    it 'enum' do
      expect(admin).to define_enum_for(:user_type)
        .with_values(administrator: 'A', collaborator: 'C')
        .backed_by_column_of_type(:string)
    end

    it 'human enum' do
      hash = { I18n.t('enums.user_types.administrator') => 'administrator',
               I18n.t('enums.user_types.collaborator') => 'collaborator' }

      expect(Admin.human_user_types).to include(hash)
    end
  end
end
