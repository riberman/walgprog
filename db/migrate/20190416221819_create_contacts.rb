class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.references :institution, foreign_key: true
      #t.string :access_token
      t.timestamps
    end
    #add_index :contacts, :access_token, unique: true
  end
end
