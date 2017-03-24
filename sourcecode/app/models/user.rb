class User < ApplicationRecord
  acts_as_messageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  has_and_belongs_to_many :followers, class_name: 'User', join_table: :connections, foreign_key: :follower_id, association_foreign_key: :followee_id
  has_and_belongs_to_many :followees, class_name: 'User', join_table: :connections, foreign_key: :followee_id, association_foreign_key: :follower_id

  # def friendship_pending(object)
  #   return (Connection.where(followee_id: self.id, follower_id: object.id, confirmed: false).first)
  # end

  def connection(object)
    return (Connection.where(follower_id: self.id, followee_id: object.id).first or  Connection.where(followee_id: self.id, follower_id: object.id).first)
  end

  # def is_friend(object)
  #   return false if ! object
  #   return (Connection.where(follower_id: self.id, followee_id: object.id, confirmed: true).first or  Connection.where(followee_id: self.id, follower_id: object.id, confirmed: true).first)
  # end  

  def mailboxer_email(object)
    #return the model's email here
  end
end
