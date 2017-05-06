require 'twemoji'

class ContentController < ApplicationController
  def emoticons
    params.require(:type)

    match_url_regexp = /<img\s+[^>]*?src=("|')([^"']+)\1/

    unless ['rude', 'default'].include?(params[:type])
      render json: {status: 404}, status: 404
      return
    end

    if params[:type] == 'default'
      allowed = %w{😀 😬 😁 😂 😃 😄 😅 😆 😇 😊 😉}
      emojis = []
      allowed.each do | emoji |
        url = ::Twemoji.parse(emoji).to_s.scan(match_url_regexp)[0][1]
        emojis.push({
          code: ::Twemoji.find_by(unicode: emoji),
          url: url
        })
      end

      render json: emojis
    else

      render json: get_rude_emoticons
    end

    # def send_rude
    #   params.require(:emoticon)
    #   emoticons = get_rude_emoticons()
    #   emoticons.include()
    # end
    #
    # def get_rude_emoticons
    #   allowed = %w{🙍 💔 🔥 😡 😈 💢 👊 👿 👹 💩 🖕 💉 💣 🔫 ☢ ☣ 💀 ⚰}
    #   emojis = []
    #   cost = 5
    #   allowed.each do |emoji|
    #     url = ::Twemoji.parse(emoji).to_s.scan(match_url_regexp)[0][1]
    #     emojis.push({
    #       code: ::Twemoji.find_by(unicode: emoji),
    #       url: url,
    #       cost: cost
    #     })
    #     cost += 5
    #   end
    #   return emojis
    # end
  end
end
