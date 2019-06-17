class Researcher < ApplicationRecord
  include ProfileImage

  enum gender: { male: 'M', female: 'F' }, _suffix: :gender

  def self.human_genders
    hash = {}
    genders.each_key { |key| hash[I18n.t("enums.genders.#{key}")] = key }
    hash
  end

  belongs_to :institution
  belongs_to :scholarity

  validates :name, presence: true
  validates :scholarity, presence: true
  validates :institution, presence: true
  validates :gender, presence: true
end
