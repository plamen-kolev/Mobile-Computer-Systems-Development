class Connection < ApplicationRecord
  validates_uniqueness_of :follower_id, :scope => :followee_id

  def confirm
    self.confirmed = true
    self.save()
  end

  def follower()
    return User.find(self.follower_id)
  end

  def get_other(current_user)
    curr_user_id = current_user.id
    if self.follower_id == curr_user_id
      return User.find(self.followee_id)
    else
      return User.find(self.follower_id)
    end
  end
end
