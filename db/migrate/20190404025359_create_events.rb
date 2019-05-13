class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :initials
      t.string :color
      t.timestamp :beginning_date
      t.timestamp :end_date
      t.string :local
      t.integer :city_id
      t.timestamps
    end
  end
end
