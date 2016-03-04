require 'rubygems'
gem 'rubyweather'

require 'weather/service'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
private

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = session['access_token']
      config.access_token_secret = session['access_token_secret']
  end
  end
  
  def weather
    @weather = Weather::Service.new
    @weather.partner_id = "123456"
    @weather.license_key = "abcdefg"
  end

  
end
