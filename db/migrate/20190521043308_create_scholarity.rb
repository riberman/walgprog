class CreateScholarity < ActiveRecord::Migration[5.2]
  def change
    create_table :scholarities do |t|
      t.string :name, unique: true
      t.string :abbr, unique: true

      t.timestamps
    end
  end
end
