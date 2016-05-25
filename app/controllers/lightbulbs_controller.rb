require 'open-uri'
require 'net/http'

class LightbulbsController < ApplicationController
  def index

    url = "http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights"
    @hue_lightbulbs = JSON.parse(open(url).read)

    @lightbulbs = Lightbulb.all
  end

  def new
    @lightbulb = Lightbulb.new
  end

  def create
    @lightbulb = Lightbulb.new
    @lightbulb.user_id = params[:user_id]
    @lightbulb.room_id = params[:room_id]
    @lightbulb.state_id = params[:state_id]
    @lightbulb.control_id = params[:control_id]
    @lightbulb.name = params[:name]

    if @lightbulb.save
      redirect_to "/lightbulbs", :notice => "Lightbulb created successfully."
    else
      render 'new'
    end
  end

  def edit
    @lightbulb = Lightbulb.find(params[:id])
  end

  def update
    @lightbulb = Lightbulb.find(params[:id])

    @lightbulb.user_id = params[:user_id]
    @lightbulb.room_id = params[:room_id]
    @lightbulb.state_id = params[:state_id]
    @lightbulb.control_id = params[:control_id]
    @lightbulb.name = params[:name]

    if @lightbulb.save
      redirect_to "", :notice => "Lightbulb updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @lightbulb = Lightbulb.find(params[:id])

    @lightbulb.destroy

    redirect_to :back, :alert => "Lightbulb deleted."
  end

  def delete_unassigned
    @lightbulbs = Lightbulb.where("user_id = ?", current_user.id).all
    @lightbulbstodestroy = @lightbulbs.where("room_id" => nil ).all

    @lightbulbstodestroy.each do |lightbulb|
      lightbulb.destroy
    end

    redirect_to :back, :alert => "Lightbulb deleted."
  end

  def import

    @lightbulbs = Lightbulb.where("user_id = ?", current_user.id).all
    countbefore = @lightbulbs.count
    url = "http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights"
    @hue_lightbulbs = JSON.parse(open(url).read)

    @lightbulbs.each do |lightbulb|
      @hue_lightbulbs.delete_if {|key, value| value["uniqueid"] == lightbulb.control_id }
    end

      @hue_lightbulbs.each do |key, value|
      @new_lightbulb = Lightbulb.new
      @new_lightbulb.user_id = current_user.id
      @new_lightbulb.control_id = @hue_lightbulbs[key]["uniqueid"]
      @new_lightbulb.name = @hue_lightbulbs[key]["name"]
      @new_lightbulb.save
    end

    @lightbulbsafter = Lightbulb.where("user_id = ?", current_user.id).all
    count = @lightbulbsafter.count - countbefore

    if count == 0
      redirect_to :back, :alert => "No new lightbulbs detected"
    else
      redirect_to :back, :notice => count.to_s + " lightbulbs imported."
    end

    # if @lightbulb.save
    #   redirect_to "/lightbulbs", :notice => "Lightbulb created successfully."
    # else
    #   render 'new'
    # end


  end

  def test


    if params[:control_id].length < 3
      id = params[:control_id]
    else
      id = find_id(params[:control_id])
    end
    uri = URI.parse("http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights/" + id + "/state")
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Put.new(uri.request_uri)
    request.body = "{\"alert\":\"lselect\"}"
    http.request(request)

    redirect_to :back
  end

  def turn_on_lightbulb
    uri = URI.parse("http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights/" + find_id(params[:control_id]) + "/state")
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Put.new(uri.request_uri)
    request.body = "{\"on\":true}"
    http.request(request)

    redirect_to :back
  end

  def turn_off_lightbulb
    uri = URI.parse("http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights/" + find_id(params[:control_id]) + "/state")
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Put.new(uri.request_uri)
    request.body = "{\"on\":false}"
    http.request(request)

    redirect_to :back
  end

  def turn_on_room

  roomlights = Lightbulb.where("room_id = ?", params[:room_id]).all


  roomlights.each do |roomlight|
    uri = URI.parse("http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights/" + find_id(roomlight.control_id) + "/state")
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Put.new(uri.request_uri)
    request.body = "{\"on\":true}"
    http.request(request)
  end

  redirect_to :back
end

def turn_off_room

  roomlights = Lightbulb.where("room_id = ?", params[:room_id]).all


  roomlights.each do |roomlight|
    uri = URI.parse("http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights/" + find_id(roomlight.control_id) + "/state")
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Put.new(uri.request_uri)
    request.body = "{\"on\":false}"
    http.request(request)
  end

  redirect_to :back
end

def test_room

  roomlights = Lightbulb.where("room_id = ?", params[:room_id]).all


  roomlights.each do |roomlight|
    uri = URI.parse("http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights/" + find_id(roomlight.control_id) + "/state")
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Put.new(uri.request_uri)
    request.body = "{\"alert\":\"lselect\"}"
    http.request(request)
  end

  redirect_to :back
end

def turn_on_all

  all_lights = Lightbulb.where.not(room_id: nil).all

  all_lights.each do |all_light|
    uri = URI.parse("http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights/" + find_id(all_light.control_id) + "/state")
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Put.new(uri.request_uri)
    request.body = "{\"on\":true}"
    http.request(request)
  end

  redirect_to :back
end

def turn_off_all

  all_lights = Lightbulb.where.not(room_id: nil).all

  all_lights.each do |all_light|
    uri = URI.parse("http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights/" + find_id(all_light.control_id) + "/state")
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Put.new(uri.request_uri)
    request.body = "{\"on\":false}"
    http.request(request)
  end

  redirect_to :back
end

def test_all

  all_lights = Lightbulb.where.not(room_id: nil).all

  all_lights.each do |all_light|
    uri = URI.parse("http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights/" + find_id(all_light.control_id) + "/state")
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Put.new(uri.request_uri)
    request.body = "{\"alert\":\"lselect\"}"
    http.request(request)
  end

  redirect_to :back
end

end
