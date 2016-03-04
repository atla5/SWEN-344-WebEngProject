module Adaptors
  class WeatherAdaptor
    require 'open_weather'
    require 'json'

    def getCurrentWeather(String city, String state)
      currentResponse = OpenWeather::Current.city_id("5134086")
      currentWeather = currentResponse.to_json
      return currentWeather
    end

    def getForcast(String city, String state)
      forcastResponse = OpenWeather::Forcast.city_id("5134086")
      weatherForcast = forcastResponse.to_json
      return weatherForcast
    end
  end
end
