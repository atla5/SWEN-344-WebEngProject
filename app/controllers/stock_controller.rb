require 'yahoo-finance'

class StockController < ApplicationController
    
    def stock_list
        if ! (session['access_token'] && session['access_token_secret'])
            redirect_to failure_path
        end
        
    end
    
    def stock_detail
        ticker = :ticker
        if(ticker != nil)
            tickerS = []
            tickerS << params[:ticker]
        yahoo_client = YahooFinance::Client.new
        data = yahoo_client.quotes(tickerS, [:name,:ask, :bid, :last_trade_date, :high, :low, :change_and_percent_change,:symbol,:low_52_weeks, :high_52_weeks,:notes])[0]
        #unless we need a list of stocks
        @singleStock = data
        end
    end
    
    ## 
    
    # - method - #
    #add a given stock id to the list of stocks the @user is following
    def follow_stock
        stock_id = params[:stockId]
        @user.addFollowing(stock_id);
    end
    
    def transact 
        
        #get parameters
        stock_id = params[:stockSymbol];
        num_shares = params[:numShares];
        stock_price = params[:stockPrice];
        note = params[:note];
        
        buy = params[:btnBuy];
        
        if buy is nil #only two inputs call it
            sell_stock(stock_id, num_shares, stock_price, note);
        else
            buy_stock(stock_id, num_shares, stock_price, note);
        end
        
    end
        
    
    # - method - #
    #try to buy a given number of shares (numShares) of a given stock (stockSymbol)
    def buy_stock(stock_id, num_shares, stock_price, note="")
        
        #use helper to create transaction and call user function to process it
        Transaction t = createTransaction(stock_id, num_shares, stock_price, note);
        result = @user.buy_transaction(t);
        
        #inform user of whether or not the change went through.
        strNumSharesOf = num_shares.to_s + " shares of " + stock_id;
        if(result)
            return "Successfully bought " + strNumSharesOf
        else
            return "Unable to buy " + strNumSharesOf;
        end
    end
    
   
    # - method - #
    #try to sell a given number of shares (numShares) of a given stock (stockSymbol)
    # by looking through the 
    def sell_stock(stock_id, num_shares, stock_price, note="")
        
        #use helper to create transaction and call user function to process it
        Transaction t = createTransaction(stock_id, num_shares, stock_price, note);
        result = @user.sell_transaction(t);
        
        #inform user of whether or not the change went through.
        strNumSharesOf = num_shares.to_s + " shares of " + stock_id;
        if(result)
            return "Successfully sold " + strNumSharesOf
        else
            return "Unable to sell " + strNumSharesOf;
        end
    end

    ## - helpers - ##
    
        
    # - method - #
    #create a transaction with a given number of shares (numShares) of a stock 
    # with a given id (stockSymbol) 
    def createTransaction(stockSymbol, numShares, stockPrice, note="")
        
        #create a transaction with a given number of shares and a stock symbol 
        t = Transaction.new;
        t.transaction_date = DateTime.current;
        t.stock_id = stock_id;
        t.stock_price = stock_price;
        t.num_shares = num_shares;
        t.transaction_note = note;

        return t;
    end

end