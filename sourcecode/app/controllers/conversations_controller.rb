class ConversationsController < ApplicationController

  before_action :authenticate_user! # , :except => [:show, :index]

  def create
    recipient = User.find(params[:user_id])
    receipt = current_user.send_message(recipient, 'hello', 'chat')
    redirect_to conversation_path(receipt.conversation)
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def new
    connection = Connection.find(params[:connection])
    recipient = nil
    if current_user.id == connection.followee_id
      recipient = User.find(connection.follower_id)
    else
      recipient = User.find(connection.followee_id)
    end
    recipe = current_user.send_message(recipient, 'new conversation started', 'chat')
    connection.conversation_id = recipe.conversation.id
    connection.save
    redirect_to conversation_path(recipe.conversation.id)
  end
  # def show

  #   @c = Conversation.find_or_create_by(id: params[:id])
  #   puts @c

  #   @messages = Message.where(
  #     "conversation_id=? AND user_id = ? OR user_id = ?", @c.id, current_user.id, @c.second_companion_id
  #   )
  #   .order('created_at ASC')
  #   .paginate(:page => params[:page], :per_page => 10)
    
  # end

  # def show_json
  #   @c = Conversation.find_or_create_by(id: params[:id])

  #   @messages = Message.where(
  #     "conversation_id=? AND user_id = ? OR user_id = ?", @c.id, current_user.id, @c.second_companion_id
  #   )
  #   .order('created_at ASC')
  #   .paginate(:page => params[:page], :per_page => 10)

  #   render json: @messages
  # end
end
