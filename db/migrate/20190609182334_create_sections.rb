class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :title
      t.string :content
      t.belongs_to :event, index: true
      t.string :status
      t.string :icon
      t.string :alternative_text
      t.integer :index
      t.timestamps
    end
  end
end