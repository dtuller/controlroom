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
      redirect_to :back, :notice => "Room created successfully."
    else
      @scene = Scene.find(6)
      @rooms = Room.order("lower(name) DESC").all
      @lightbulbs = Lightbulb.all
      redirect_to :back, :alert => "Room already exists"
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
      redirect_to "", :notice => "Room updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @room = Room.find(params[:id])

    Lightbulb.where(:room_id => params[:id]).find_each do |lightbulb|
      lightbulb.room_id = nil
      lightbulb.save
    end

    @room.destroy

    redirect_to :back, :notice => "Room deleted."
  end
end
