class ConversationsController < ApplicationController

  before_action :authenticate_user! # , :except => [:show, :index]

  def show

    @c = Conversation.find_or_create_by(id: params[:id])
    puts @c

    @messages = Message.where(
      "conversation_id=? AND user_id = ? OR user_id = ?", @c.id, current_user.id, @c.second_companion_id
    )
    .order('created_at ASC')
    .paginate(:page => params[:page], :per_page => 10)
    
  end

  def show_json
    @c = Conversation.find_or_create_by(id: params[:id])

    @messages = Message.where(
      "conversation_id=? AND user_id = ? OR user_id = ?", @c.id, current_user.id, @c.second_companion_id
    )
    .order('created_at ASC')
    .paginate(:page => params[:page], :per_page => 10)

    render json: @messages
  end
end
