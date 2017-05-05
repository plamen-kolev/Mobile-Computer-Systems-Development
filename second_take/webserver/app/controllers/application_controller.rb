class ApplicationController < ActionController::Base
  include Knock::Authenticable
  undef_method :current_user

  protect_from_forgery with: :exception
  # protect_from_forgery unless: -> { request.format.json? }
  skip_before_filter :verify_authenticity_token
  before_action :set_current_locale

  private
    def set_current_locale
      current_locale = 'en' # default one
      current_locale = params[:locale] if params[:locale]  # or add here some checking

      I18n.locale = current_locale # if it doesn't work, add .to_sym
    end


end
