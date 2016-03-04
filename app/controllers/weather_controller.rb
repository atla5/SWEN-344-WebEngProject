class WeatherController < ApplicationController
  require 'open_weather'
  require 'json'
  require 'Adaptors/WeatherAdaptor'

  def current
    response = WeatherAdaptor::getCurrentWeather("Rochester", "NY")
    
  end

  def forcast
  end
end
