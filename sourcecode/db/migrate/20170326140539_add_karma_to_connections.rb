class AddKarmaToConnections < ActiveRecord::Migration[5.0]
  def change
    add_column :connections, :follower_karma, :integer
    add_column :connections, :followee_karma, :integer
  end
end
