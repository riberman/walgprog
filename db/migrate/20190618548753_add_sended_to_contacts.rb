class AddSendedToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :sended, :datetime
  end
end
