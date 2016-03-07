require 'yahoo-finance'

class StockController < ApplicationController
    
    def stockList
        if ! (session['access_token'] && session['access_token_secret'])
            redirect_to failure_path
        end
        
    end
    
    def single_stock
        ticker = :ticker
        if(ticker != nil)
            tickerS = []
            tickerS << params[:ticker]
        yahoo_client = YahooFinance::Client.new
        data = yahoo_client.quotes(tickerS, [:name,:ask, :bid, :last_trade_date, :high, :low, :change_from_200_day_moving_average])
        #unless we need a list of stocks
        @singleStock = data
        end
    end


end