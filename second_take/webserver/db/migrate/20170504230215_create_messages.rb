class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :sender_id, null: false
      t.integer :recipient_id, null: false
      t.text :body, null: false
      t.integer :connection_id, null: false

      t.timestamps
    end
  end
end