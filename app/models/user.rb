class User < ActiveRecord::Base
    attr_accessible :num_shares_of_stock, :balance, :addFollowing, :get_following, :get_owned, :get_transactions, :buy_transaction, :sell_transaction;
    
    validates :handle,
              presence: true,
              length: { minimum: 2 },
              uniqueness: true
              
    validates_numericality_of :zip
    validates_numericality_of :tweet_count
    validates_numericality_of :follower_count
    validates_presence_of :name
    has_many :events
    
    
    #stocks
    has_many :transactions
    has_many :stocks_owned
    has_many :stocks_following
    has_one  :balance 
    
    
    ## -- accessors -- ## 
    
    # get a list of strings of the Ids of the owned stocks
    def get_owned
        lsOwned = []
        for stock in :stocks_owned
            lsOwned.push(stock.stockId)
        end
        return lsOwned
    end
    
    # return the number of shares owned of given stockId
    def num_shares_of_stock(stockId)
        for stock in :stocks_owned
            if(stock.id == stockId)
                return stock.shares;
            end
        end
        return 0;
    end
    
    #return a list of strings representing the ids user is following
    def get_following
        return :stocks_following;
    end
    
    #return a list of transactions relevant to the stockId
    def get_transactions(stockId)
        lsToReturn = []
        for t in :transactions
            if(t.stockId == stockId)
                lsToReturn.push(t)
            end
        end
        return lsToReturn;
    end
    
    ## -- external helpers -- ##
    
    #add the string for a stockId to private list
    def addFollowing(stockId)
        
        #only add the stockId if it's not already there
        if(! :stocks_following.include(stockId))
            :stocks_following.push(stockId)
            save
        end
        
    end
    
    ## - Transaction methods - ##
    
    #enact a 'buy' transaction, subtracting from balance and adding to stocks_owned
    def buy_transaction(t)
        
        #transaction info
        total_cost = t.getTransactionAmount;
        
        #return false if you can't afford it
        if( total_cost > balance )
            return false;
        else
            
            #add stock to the list of following
            addFollowing(t.stockId);
            
            #add shares of stock to the inventory
            addToInventory(t.stockId, t.shares);
            
            #subtract total amount from balance
            subtract_from_balance(total_cost);
            
            save
            
            return true;
            
        end
    end
    
    
    #enact 'sell' transaction, adding to balance and subtracting from inventory
    def sell_transaction(t)
        
        #check inventory for the right number of shares of given stock
        if(t.numShares > num_shares_of_stock(t.stockId))
            return false;
        end
        
        #remove stocks from the inventory (by adding the negative)
        add_to_shares(t.stockId, t.numShares * -1)
        
        #add total transaction amount to balance
        this.balance += t.getTransactionAmount;
        save
        return true;
    
    end
    
    
    ## - internal helpers - ##
    
    #return whether or not stock is in stocks_owned
    def owns_stock(stockId)
        for stock in :stocks_owned
            if(stock.stockId == stockId)
                return true;
            end 
        end
        return false;
    end
    
    #add to the number of shares for given stock
    def add_to_shares(id, amt)
        for s in :stocks_owned
            if(s.stockId == id)
                s.numShares += amt
                return true
            end
        end
       
        #should have found stock by id 
        return false;
    end
    
    # safely subtract from the balance and ensure that there will be no negatives
    def subtract_from_balance(amt)
        if(amt > this.balance)
            this.balance = 0;
            return false;
        else
            this.balance -= amt;
            return true;
        end
    end
    
    # add a given number of shares of a given stock to users inventory
    def addToInventory(stockId, numShares)
       
        #if the stock already exists in inventory, simply increment numShares
        if( owns_stock(stockId))
            add_to_shares(stockId, numShares);
        
        #if it does not, create and add.
        else
            new_stock = Stock.new 
            new_stock.stockId = stockId
            new_stock.numShares = numShares
            stocks_owned.push(new_stock)
        end
       
    end
    
end