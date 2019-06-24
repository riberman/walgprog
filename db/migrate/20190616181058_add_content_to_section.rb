class AddContentToSection < ActiveRecord::Migration[5.2]
  def change
    change_table :sections, bulk: true do |t|
      t.text :content_markdown
      t.text :description_short
    end
  end
end
