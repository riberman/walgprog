class Section < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :event

  validates :title, :content, :status, :icon, :index, :event_id, presence: true
  validates :alternative_text, presence: true, if: :other_status?

  enum status: { active: 'A', inactive: 'I', other: 'O' }

  def self.human_status_types
    hash = {}
    statuses.each_key { |key| hash[I18n.t("enums.status_types.#{key}")] = key }
    hash
  end

  def other_status?
    status.eql?('other')
  end
end
