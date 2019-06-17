class CreateResearcher < ActiveRecord::Migration[5.2]
  def change
    create_table :researchers do |t|
      t.string :name
      t.string :gender
      t.string :image

      t.belongs_to :scholarity, foreign_key: true
      t.belongs_to :institution, foreign_key: true

      t.timestamps
    end
  end
end
