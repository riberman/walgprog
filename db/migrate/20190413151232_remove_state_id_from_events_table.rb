class RemoveStateIdFromEventsTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :state_id, :integer
  end
end
