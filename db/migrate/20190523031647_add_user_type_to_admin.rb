class AddUserTypeToAdmin < ActiveRecord::Migration[5.2]
  def change
    change_table :admins do |t|
      t.string :user_type, limit: 1
    end
  end
end
