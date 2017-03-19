class Connection < ApplicationRecord
  validates_uniqueness_of :follower_id, :scope => :followee_id

  def confirm
    self.confirmed = true
    self.save()
  end

  def follower()
    return User.find(self.follower_id)
  end
end
