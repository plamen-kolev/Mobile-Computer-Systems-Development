class AddKarmaToConnections < ActiveRecord::Migration[5.0]
  def change
    add_column :connections, :follower_karma, :integer, :default => 0
    add_column :connections, :followee_karma, :integer, :default => 0
  end
end
