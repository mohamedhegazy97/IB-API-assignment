class AddChatCountToApplications < ActiveRecord::Migration[6.1]
  def change
    add_column :applications, :chat_count, :integer
  end
end
