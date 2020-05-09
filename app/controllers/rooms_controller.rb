class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all.order(:id)
    @genres = Genre.all
    @categories = Category.all
  end

  def create
    @room = Room.new
    @room.save
    redirect_to rooms_path
  end

  def show
    #binding.pry
    @room = Room.find(params[:id])
    @messages = @room.messages.recent.limit(5).reverse
  end
end
