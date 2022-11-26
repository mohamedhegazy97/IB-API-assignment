class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :number
      t.references :application, null: false, foreign_key: true
      t.string :AppToken

      t.timestamps
    end
    add_index :chats ,[:AppToken,:created_at]
  end
end
