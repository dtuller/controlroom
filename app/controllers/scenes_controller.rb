class ScenesController < ApplicationController
  def index
    @scenes = Scene.all
  end

  def show
    @scene = Scene.find(params[:id])
    @rooms = Room.all
    @lightbulbs = Lightbulb.all
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
