class ConversationsController < ApplicationController
  def show
    c = Conversation.find_or_create_by(first_companion_id: current_user.id, second_companion_id:params[:partner_id])
    
  end
end
