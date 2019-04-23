require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validates' do
    [:name,
     :city_id,
     :beginning_date,
     :end_date,
     :color,
     :initials,
     :local,
     :address].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
