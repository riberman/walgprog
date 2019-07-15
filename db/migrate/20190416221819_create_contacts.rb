class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.boolean :unregistered, default: false

      t.string   :unregister_token
      t.datetime :unregister_send_at

      t.string   :update_token
      t.datetime :update_send_at

      t.references :institution, foreign_key: true
      t.timestamps
    end
  end
end
