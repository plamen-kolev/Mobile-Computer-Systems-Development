class AddLastReadFollowerAndLastReadFollowee < ActiveRecord::Migration[5.0]
  def change
    add_column :connections, :followee_lastread_sid, :string
    add_column :connections, :follower_lastread_sid, :string

    add_column :connections, :followee_lastread_ts, :datetime
    add_column :connections, :follower_lastread_ts, :datetime
  end
end
