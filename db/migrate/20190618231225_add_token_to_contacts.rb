class AddTokenToContact < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :unregistered_token
      t.timestamp :unregistered_token_send_at
      t.boolean :register_status
  end
end
