class WelcomeController < ApplicationController
  
  require 'open_weather'

  # GET /welcome
  def index
    @current = OpenWeather::Current.city_id("5134086", { units: "imperial", APPID: "106fc5306b995d8409aa88eb9cc548d4" })
  end

end
