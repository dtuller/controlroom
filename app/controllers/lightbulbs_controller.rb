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
      redirect_to "/lightbulbs", :notice => "Lightbulb updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @lightbulb = Lightbulb.find(params[:id])

    @lightbulb.destroy

    redirect_to "/lightbulbs", :notice => "Lightbulb deleted."
  end

  def import

    @lightbulb = Lightbulb.all
    url = "http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights"
    @hue_lightbulbs = JSON.parse(open(url).read)

    @lightbulb.each do |lightbulb|
      @hue_lightbulbs.delete_if {|key, value| value["uniqueid"] == lightbulb.control_id }
    end

  end

  def test

    uri = URI.parse("http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights/" + params[:id] + "/state")
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

end
