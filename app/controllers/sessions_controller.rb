require 'rubygems'
require 'weather-api'
require 'yahoo-finance'

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
      @forecast = Weather.lookup(12763350, Weather::Units::FAHRENHEIT)
      @stocks = stocklist
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
  
   #function to pull 5 stocks with their [ ]
  def stocklist
    stocks = ['AAPL', 'MSFT', 'BAC', 'JCP', 'JPM']
    columns = [:ask, :bid, :last_trade_date]
    ycl = YahooFinance::Client.new
    mainList = ycl.quote(stocks,columns)
    return mainList
  end
  
end
