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

  def self.get_by_user(user, channel)
    current_user = user.id
    return self.where(follower_id: current_user, channel: channel).or(self.where(followee_id: current_user, channel: channel)).first
  end

  def subtract_karma(current_user, karma)
    current_user_id = current_user.id
    current_karma = 0
    if self.follower_id == current_user_id
      self.follower_karma -= karma.to_i
      current_karma = self.follower_karma
    else
      self.followee_karma -= karma.to_i
      current_karma = self.followee_karma
    end
    self.save()
    return current_karma.to_i
  end

  def get_karma(current_user)
    
    curr_user_id = current_user.id
    if self.follower_id == curr_user_id
      
      return self.follower_karma
    else
      
      return self.followee_karma
    end
  end
end
