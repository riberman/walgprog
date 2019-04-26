require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validates' do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_presence_of(:email)}

    context 'email' do
      it { is_expected.to allow_value('email@addresse.foo').for(:email) }
      it { is_expected.to allow_value('email@addresse.foo.foo').for(:email) }
      it { is_expected.to_not allow_value('foo').for(:email) }
    end
  end

  describe 'associations' do
    it {is_expected.to belong_to(:institution)}
  end
end
