class ChangeEventDatesType < ActiveRecord::Migration[5.2]
  def change
    change_table :events, bulk: true do |table|
      table.timestamp :beginning_date
      table.timestamp :end_date
    end
  end
end
