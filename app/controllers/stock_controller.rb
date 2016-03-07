require 'yahoo-finance'

class StockController < ApplicationController
    
    def stockList
        if ! (session['access_token'] && session['access_token_secret'])
            redirect_to failure_path
        end
        
    end
    
    def single_stock
        
        #grab a single stock from the entered ticker symbol
        stockName = #POST information
        ycl = YahooFinance::Client.new   
        @stockInfo = ycl.quotes(stockName, [:ask, :bid, :last_trade_date, :high, :low, :change_from_200_day_moving_average])
        
        #unless we need a list of stocks
        
    end


    
    
end