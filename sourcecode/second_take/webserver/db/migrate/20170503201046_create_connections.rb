class CreateConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :connections do |t|
      t.boolean :confirmed
      t.integer :l_id
      t.integer :r_id
      t.string :channel
      t.string :follower_lastread
      t.string :followee_lastread
      t.integer :follower_karma
      t.integer :followee_karma

      t.timestamps
    end
  end
end
