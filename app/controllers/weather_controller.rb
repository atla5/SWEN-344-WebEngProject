class WeatherController < ApplicationController
  require 'open_weather'
  require 'json'
  require 'Adaptors/WeatherAdaptor'

  def current
   @current = WeatherAdaptor::getCurrentWeather("Rochester", "NY") 
  end

  def forcast
  end
end
