class AddContentToSection < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :content_markdown, :text
    add_column :sections, :description_short, :text
  end
end
