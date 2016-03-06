require 'rubygems'
require 'weather-api'
require 'open_weather'

class SessionsController < ApplicationController
  def create
    credentials = request.env['omniauth.auth']['credentials']
    session[:access_token] = credentials['token']
    session[:access_token_secret] = credentials['secret']
    redirect_to show_path, notice: 'Signed in'
  end

  def show
    if session['access_token'] && session['access_token_secret']
      @user = client.user(include_entities: true)
      @tweets = client.home_timeline[0..10]
      @current = OpenWeather::Current.city_id("5134086", { units: "imperial", APPID: "106fc5306b995d8409aa88eb9cc548d4" })

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
  
  def getStocks
    yahoo_client = YahooFinance::Client.new
    data = yahoo_client.quotes(['AAPL','MSFT','JPC', 'TWTR', 'LUV' ], [:name, :ask, :bid, :last_trade_date])
    cuddle =[]
    data.each { |x| slut = x.name + " has a value: " + x.ask
        cuddle << slut
    }
        
    @stocks = cuddle
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
