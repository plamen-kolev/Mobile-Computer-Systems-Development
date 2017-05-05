class ContentController < ApplicationController
  def emoticons
    params.require(:type)

    unless ['rude', 'default'].include?(params[:type])
      render json: {status: 404}, status: 404
      return
    end

    files = Dir.glob("public/images/emoticons/#{params[:type]}/*")

    index = 0
    result = Array.new
    modifier = 0

    modifier = 5 if params[:type] == 'rude'
    files.map{ |f|
      url = f.split('/')
      url.shift()
      url = url.join('/')
      result[index] = {
        url: url,
        points: index * modifier
      }
      index += 1
    }
    render json: result
  end
end
