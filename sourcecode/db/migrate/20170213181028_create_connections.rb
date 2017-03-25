class CreateConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :connections do |t|
      t.boolean :confirmed, :default => false
      t.timestamps
    end
    add_column :connections, :follower_id, :integer
    add_column :connections, :followee_id, :integer
    add_column :connections, :channel, :string

    add_foreign_key :connections, :users, column: :follower_id
    add_foreign_key :connections, :users, column: :followee_id
  end
end
