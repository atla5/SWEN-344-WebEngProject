require 'rubygems'
require 'open_weather'
require 'yahoo-finance'

class SessionsController < ApplicationController
  def create
    credentials = request.env['omniauth.auth']['credentials']
    session[:access_token] = credentials['token']
    session[:access_token_secret] = credentials['secret']
    user = User.where(handle: client.user.screen_name).take
    if user.nil?
      u = User.new(
        name: client.user.name,
        handle: client.user.screen_name,
        zip: 14623,
        tweet_count: 0,
        follower_count: 0)
      u.save
    end
    redirect_to show_path, notice: 'Signed in'
  end

  def show
    if session['access_token'] && session['access_token_secret']
      @user = User.where(handle: client.user.screen_name).take
      @user.tweet_count = client.user.tweets_count
      @user.follower_count = client.user.followers_count
      @tweets = client.home_timeline[0..10]
      @current = OpenWeather::Current.city_id("5134086", { units: "imperial", APPID: "106fc5306b995d8409aa88eb9cc548d4" })
      yahoo_client = YahooFinance::Client.new
      ycl = yahoo_client.quotes(['AAPL','MSFT','JPC', 'TWTR', 'LUV' ], [:name, :ask, :bid, :high, :low, :change, :symbol, :last_trade_date])
      @stocks = ycl
    else
      redirect_to failure_path
    end
  end
  
  def writetweet
    if session['access_token'] && session['access_token_secret']
      @tweet = params[:tweet]
      client.update(@tweet)
      redirect_to show_path
    else
      redirect_to failure_path
    end
  end
  

  def error
    flash[:error] = 'Sign in with Twitter failed'
    redirect_to root_path
  end
  
  def destroy
    reset_session
    redirect_to root_path, notice: 'Signed out'
  end
  
end
