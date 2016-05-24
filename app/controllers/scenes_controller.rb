class ScenesController < ApplicationController
  def index
    @scenes = Scene.all
  end

  def show
    if params[:id].present?
      @scene = Scene.find(params[:id])
    end
    @scenes = Scene.where("user_id = ?", current_user.id).all
    @rooms = Room.where("user_id = ?", current_user.id).order("lower(name) ASC").all
    @lightbulbs = Lightbulb.where("user_id = ?", current_user.id).order("lower(name) ASC")

  end

  def new
    @scene = Scene.new
  end

  def create
    @scene = Scene.new
    @scene.user_id = params[:user_id]
    @scene.name = params[:name]

    if @scene.save
      redirect_to "/scenes/#{@scene.id}", :notice => "Scene created successfully."
    else
      render 'new'
    end
  end

  def edit
    @scene = Scene.find(params[:id])
  end

  def update
    @scene = Scene.find(params[:id])

    @scene.user_id = params[:user_id]
    @scene.name = params[:name]

    if @scene.save
      redirect_to "/scenes/#{@scene.id}", :notice => "Scene updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @scene = Scene.find(params[:id])

    @scene.destroy

    redirect_to "/scenes", :notice => "Scene deleted."
  end

end
