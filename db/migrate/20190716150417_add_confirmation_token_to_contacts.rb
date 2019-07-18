class AddConfirmationTokenToContacts < ActiveRecord::Migration[5.2]
  def change
    change_table :contacts, bulk: true do |t|
      t.column :confirmation_token, :string
      t.column :confirmation_send_at, :datetime
      t.column :confirmed_at, :datetime
    end
  end
end
