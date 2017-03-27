class ConversationsController < ApplicationController

  before_action :authenticate_user!, :set_karma_values # , :except => [:show, :index]

  def show
    @connection = Connection.where(channel: params[:channel]).first
    if ! (@connection.follower_id == current_user.id or @connection.followee_id == current_user.id)
      raise "You are not assoc
      iated with this conversation"
    end
    @good_emoticons = Dir.glob("app/assets/images/emoticons/*.svg")
    @rude_emoticons = get_rude_emoticons(@connection.channel)
    # sort rude emoticons

    @channel = @connection.channel
  end

  def new
    connection = Connection.find(params[:connection])
    ip_messaging_client = Twilio::REST::IpMessagingClient.new(ENV['API_KEY_SID'], ENV['API_KEY_SECRET'])

    # Create the channel
    service = ip_messaging_client.services.get(ENV['IPM_SERVICE_SID'])

    channel = service.channels.create()

    connection.channel = channel.sid
    connection.save()
    redirect_to root_path

  end
  
  def render_good_emoticons
    @good_emoticons = Dir.glob("app/assets/images/emoticons/*.svg")
    render_emoticons_to_html(@good_emoticons)
  end

  def render_rude_emoticons
      params.require(:channel)
      @emoticons = get_rude_emoticons(params[:channel])
      render_emoticons_to_html(@emoticons, true, params[:channel])
  end

  def send_negative_emoticon()
    params.require(:emoticon_id)
    params.require(:channel)
    emoticon_id = params[:emoticon_id].to_i
    
    c = Connection::get_by_user(current_user, params[:channel])
    karma = c.subtract_karma(current_user, @karma_required[emoticon_id])
    
    msg = {:karma => karma}
    render :json => msg
  end

  def update_last_read()
    params.permit(:channel, :message_index)
    sid = params[:channel]
    mindex = params[:message_index]

    raise "Value error" if not sid
    raise "Value error " if not mindex

    c = Connection.where(channel: sid).first
    raise "Unable to find entity" if not c

    cuser = current_user
    if c.follower_id == current_user.id
      c.follower_lastread_index = mindex
      c.follower_lastread_ts = Time.now.utc.iso8601
    else
      c.followee_lastread_index = mindex
      c.followee_lastread_ts = Time.now.utc.iso8601
    end
    c.save()
  end

  private

    def render_emoticons_to_html(emoticons, rude=false, channel=nil)
      content = "<div class='emoticon_container'>" 
      emoticons.each do |image|
          @image_url = image.gsub('app/assets/images/', '')
          @image_id = image.split('/')[-1].split('.')[0].gsub(/[\/-]/, '_')
          if rude and @image_id != "error"
          end
          content += ActionController::Base.helpers.image_tag(@image_url, 
                size: '30x30', 
                id: @image_id, 
          )
      end
      content += "</div>" 
      render html: content.html_safe
    end

    def set_karma_values
      @karma_required = [10,10,10,40,40,50,50,60,60,100,200,200,300,320,320,320,400,400,400,500]
    end

    def get_rude_emoticons(channel)
      c = Connection.get_by_user(current_user, channel)
      
      current_karma = c.get_karma(current_user)
      @rude_emoticons = Dir.glob("app/assets/images/rude_emoticons/*.svg")
    
      @rude_emoticons.sort! { |a,b| 
        a = a.split('/')[-1].split('.')[0].gsub(/[\/-]/, '_').to_i
        b = b.split('/')[-1].split('.')[0].gsub(/[\/-]/, '_').to_i
        a <=> b
      }

      for i in 0..@karma_required.length - 1
        if @karma_required[i] > current_karma
          @rude_emoticons[i] = "app/assets/images/error.svg"
        end
        
      end

      return @rude_emoticons
    end

end
