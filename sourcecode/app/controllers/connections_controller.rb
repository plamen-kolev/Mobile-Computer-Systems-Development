class ConnectionsController < ApplicationController
  def create
    Connection.create(follower_id: current_user.id, followee_id: params[:connection][:followee_id])
  end
end
