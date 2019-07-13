class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :title
      t.string :icon
      t.text :content
      t.text :content_md
      t.text :alternative_content
      t.text :alternative_content_md
      t.integer :position

      t.belongs_to :event, index: true
      t.timestamps
    end
  end
end
