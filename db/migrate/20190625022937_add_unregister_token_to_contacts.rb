class AddUnregisterTokenToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :unregister_token, :string
    add_column :contacts, :update_data_token, :string
    add_column :contacts, :update_data_send_at, :datetime
    add_column :contacts, :unregistered, :boolean, default: false
  end
end
