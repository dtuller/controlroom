class SceneLightbulbStatesController < ApplicationController
  def index
    @scene_lightbulb_states = SceneLightbulbState.all
  end

  def show
    @scene_lightbulb_state = SceneLightbulbState.find(params[:id])
  end

  def new
    @scene_lightbulb_state = SceneLightbulbState.new
  end

  def create
    @scene_lightbulb_state = SceneLightbulbState.new
    @scene_lightbulb_state.scene_id = params[:scene_id]
    @scene_lightbulb_state.state_id = params[:state_id]
    @scene_lightbulb_state.lightbulb_id = params[:lightbulb_id]

    if @scene_lightbulb_state.save
      redirect_to "/scene_lightbulb_states", :notice => "Scene lightbulb state created successfully."
    else
      render 'new'
    end
  end

  def edit
    @scene_lightbulb_state = SceneLightbulbState.find(params[:id])
  end

  def update
    @scene_lightbulb_state = SceneLightbulbState.find(params[:id])

    @scene_lightbulb_state.scene_id = params[:scene_id]
    @scene_lightbulb_state.state_id = params[:state_id]
    @scene_lightbulb_state.lightbulb_id = params[:lightbulb_id]

    if @scene_lightbulb_state.save
      redirect_to "/scene_lightbulb_states", :notice => "Scene lightbulb state updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @scene_lightbulb_state = SceneLightbulbState.find(params[:id])

    @scene_lightbulb_state.destroy

    redirect_to "/scene_lightbulb_states", :notice => "Scene lightbulb state deleted."
  end
end
