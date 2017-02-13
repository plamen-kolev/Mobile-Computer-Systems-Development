class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.timestamps
    end

    add_reference :messages, :user, references: :users, index: true
    add_foreign_key :messages, :users, column: :user_id

    add_reference :messages, :conversation, references: :conversation, index: true
    add_foreign_key :messages, :conversations, column: :conversation_id
  end
end
