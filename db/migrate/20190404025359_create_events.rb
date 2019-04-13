class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :initials
      t.string :color
      t.date :beginning_date
      t.date :end_date
      t.string :local
      t.integer :city_id
      t.integer :state_id

      t.timestamps
    end
  end
end
