class CreateSponsorEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :sponsor_events do |t|
      t.belongs_to :event, index: true
      t.belongs_to :institution, index: true

      t.timestamps
    end
  end
end
