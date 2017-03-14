class PagesController < ApplicationController
  def index
    @people = User.all
    @connection = Connection.new
  end
end
