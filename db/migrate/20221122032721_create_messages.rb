class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :chat_number
      t.references :chat, null: false, foreign_key: true
      t.integer :number
      t.string :content

      t.timestamps
    end
  end
end
