class AddIndexToConnections < ActiveRecord::Migration[5.0]
  def change
    add_index :connections, :conversation_id, unique: true
  end
end
