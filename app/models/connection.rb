class Connection < ApplicationRecord
  validates_uniqueness_of :follower_id, :scope => :followee_id
end
