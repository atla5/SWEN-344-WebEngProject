require 'yahoo-finance'

class StockController < ApplicationController
    
    yahoo_client = YahooFinance::Client.new
    
    def stockList
        if ! (session['access_token'] && session['access_token_secret'])
            redirect_to failure_path
        end
        
    end
    
end