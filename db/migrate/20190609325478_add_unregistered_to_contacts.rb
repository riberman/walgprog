class AddUnregisteredToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :unregistered, :boolean
  end
end
