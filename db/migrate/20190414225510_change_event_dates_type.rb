class ChangeEventDatesType < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :beginning_date, :timestamp
    change_column :events, :end_date, :timestamp
  end
end
