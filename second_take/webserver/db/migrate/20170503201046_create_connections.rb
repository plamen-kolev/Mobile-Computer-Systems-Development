class CreateConnections < ActiveRecord::Migration[5.0]
  def change
    create_table :connections do |t|
      t.boolean :confirmed, default: false
      t.integer :l_id, null: false
      t.integer :r_id, null: false
      t.string :channel
      t.string :l_lastread
      t.string :r_lastread
      t.integer :l_karma , default:0
      t.integer :r_karma, default:0

      t.timestamps
    end
  end
end
