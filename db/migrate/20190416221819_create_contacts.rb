class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.references :institution, foreign_key: true
      t.string :unregister_token
      t.string :update_data_token
      t.datetime :update_data_send_at
      t.boolean :unregistered, default: false
      t.timestamps
    end
  end
end
