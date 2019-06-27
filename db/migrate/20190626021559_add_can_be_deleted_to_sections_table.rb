class AddCanBeDeletedToSectionsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :can_be_deleted, :boolean, default: true
  end
end
