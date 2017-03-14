class CreateConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :connections do |t|

      t.timestamps
    end
    add_column :connections, :follower_id, :integer
    add_column :connections, :followee_id, :integer
  end
end
