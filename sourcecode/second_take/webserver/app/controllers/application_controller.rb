class ApplicationController < ActionController::Base
  include Knock::Authenticable
  undef_method :current_user

  protect_from_forgery with: :exception
  if Rails.env.development?
    skip_before_action :verify_authenticity_token
  end
end
