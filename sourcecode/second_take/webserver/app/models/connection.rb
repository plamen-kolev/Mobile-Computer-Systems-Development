class Connection < ApplicationRecord
  belongs_to :users, :primary_key => :id, foreign_key: 'l_id'
  belongs_to :users, :primary_key => :id, foreign_key: 'r_id'
end
