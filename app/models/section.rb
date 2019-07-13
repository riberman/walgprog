class Section < ApplicationRecord
  belongs_to :event

  validates :title, :content_md, :status, :icon, presence: true
  validates :alternative_text_md, presence: true, if: -> { alternative_text? }

  before_create :set_index
  before_save :md_to_html

  enum status: { active: 'active', inactive: 'inactive', alternative_text: 'alternative_text' }

  def self.human_statuses
    hash = {}
    statuses.each_key { |key| hash[I18n.t("enums.section_statuses.#{key}")] = key }
    hash
  end

  private

  def md_to_html
    self.content = MarkdownRenders::HTML.render(content_md)
    self.alternative_text = MarkdownRenders::HTML.render(alternative_text_md)
  end

  def set_index
    self.index = Section.count + 1
  end
end
