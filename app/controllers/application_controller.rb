class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :enable_navbar
private

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = session['access_token']
      config.access_token_secret = session['access_token_secret']
  end
  end
  
  def enable_navbar
    if session['access_token'] && session['access_token_secret']
      @loggedIn = true
    else
      @loggedIn = false
    end
  end
  
end
