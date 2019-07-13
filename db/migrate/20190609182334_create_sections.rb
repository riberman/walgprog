class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :title
      t.string :icon
      t.text :content
      t.text :content_md
      t.text :alternative_text
      t.text :alternative_text_md
      t.integer :index

      t.belongs_to :event, index: true
      t.timestamps
    end
  end
end
