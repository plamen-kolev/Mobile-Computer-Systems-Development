class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :followers, class_name: 'User', join_table: :connections, foreign_key: :follower_id, association_foreign_key: :followee_id
  has_and_belongs_to_many :followees, class_name: 'User', join_table: :connections, foreign_key: :followee_id, association_foreign_key: :follower_id

  def is_friend(object)
    return 0 if ! object
    return object.followers.include?(self)
  end  
end
