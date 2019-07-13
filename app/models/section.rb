class Section < ApplicationRecord
  belongs_to :event

  validates :title, :content_md, :status, :icon, presence: true
  validates :alternative_content_md, presence: true, if: -> { alternative_content? }

  before_create :set_position
  before_save :md_to_html

  enum status: { active: 'active', inactive: 'inactive',
                 alternative_content: 'alternative_content' }

  def self.human_statuses
    hash = {}
    statuses.each_key { |key| hash[I18n.t("enums.section_statuses.#{key}")] = key }
    hash
  end

  private

  def md_to_html
    self.content = MarkdownRenders::HTML.render(content_md)
    self.alternative_content = MarkdownRenders::HTML.render(alternative_content_md)
  end

  def set_position
    self.position = Section.count + 1
  end
end
