class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      # t.integer :first_companion_id
      # t.integer :second_companion_id

      t.timestamps
    end
    
    add_reference :conversations, :first_companion, references: :users, index: true
    add_foreign_key :conversations, :users, column: :first_companion

    add_reference :conversations, :second_companion, references: :users, index: true
    add_foreign_key :conversations, :users, column: :second_companion
  end
end
