require 'open-uri'
require 'net/http'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  private def find_id (control_id)
    url = "http://192.168.1.6/api/2c52addb187cad2f12b4c8e33012b2b7/lights"
    @hue_lightbulbs = JSON.parse(open(url).read)
    lightbulb = @hue_lightbulbs.select {|key, hash| hash["uniqueid"] == control_id }
    return lightbulb.keys[0]
  end
  helper_method :find_id

end
