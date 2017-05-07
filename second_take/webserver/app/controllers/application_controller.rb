class ApplicationController < ActionController::Base
  include Knock::Authenticable
  undef_method :current_user

  protect_from_forgery with: :exception
  # protect_from_forgery unless: -> { request.format.json? }
  skip_before_action :verify_authenticity_token
  # before_action :set_current_locale

  private
    # def set_current_locale
    #   current_locale = 'en' # default one
    #   current_locale = params[:locale] if params[:locale]  # or add here some checking
    #
    #   I18n.locale = current_locale # if it doesn't work, add .to_sym
    # end

    def get_rude_emoticons
      match_url_regexp = /<img\s+[^>]*?src=("|')([^"']+)\1/
      allowed = %w{🙍 💔 🔥 😡 😈 💢 👊 👿 👹 💩 🖕 💉 💣 🔫 ☢ ☣ 💀 ⚰}
      emojis = []
      cost = 5
      allowed.each do |emoji|
        url = ::Twemoji.parse(emoji).to_s.scan(match_url_regexp)[0][1]
        emojis.push({
          code: ::Twemoji.find_by(unicode: emoji),
          url: url,
          cost: cost
        })
        cost += 5
      end
      return emojis
    end
end
