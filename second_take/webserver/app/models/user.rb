class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  alias_method :authenticate, :valid_password?

  def self.from_token_payload(payload)
   self.find payload["sub"]
  end

  def current
      return begin
        token = params[:token] || request.headers['Authorization'].split.last
        Knock::AuthToken.new(token: token).current_user
      rescue
        nil
      end
    end

end
