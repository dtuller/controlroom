class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new
    @room.user_id = params[:user_id]
    @room.name = params[:name]

    if @room.save
      redirect_to "/rooms", :notice => "Room created successfully."
    else
      render 'new'
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])

    @room.user_id = params[:user_id]
    @room.name = params[:name]

    if @room.save
      redirect_to "/rooms", :notice => "Room updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @room = Room.find(params[:id])

    @room.destroy

    redirect_to "/rooms", :notice => "Room deleted."
  end
end
