class User < ActiveRecord::Base
    validates :handle,
              presence: true,
              length: { minimum: 2 },
              uniqueness: true
              
    validates_numericality_of :zip
    validates_presence_of :name
    has_many :events
    
    #twitter 
    validates_numericality_of :tweet_count
    validates_numericality_of :follower_count
    
    #stocks
    has_many :transactions      #the transaction history for the user
    has_one  :inventory         #the current shares of stock the user owns
    has_many :stocks_following  #the stocks the user has favorited or 'watched'
    has_one  :balance           #user's current balance
    
    ## - Transaction methods - ##
    
    def buy_transaction(t)
        total_cost = t.getTransactionAmount;
        
        if( total_cost > balance )
            return false;
        else
            
            #add shares of stock to the inventory
            addToInventory(t.stockId, t.shares);
            
            #subtract total amount from balance
            subtract_from_balance(total_cost);
            
            return true;
            
        end
    end
    
    
    #
    def sell_transaction(t)
        
        #check inventory for the right number of shares of given stock
        
        #remove stocks from the inventory
        
        #add total transaction amount to balance
        this.balance += t.getTransactionAmount;
        return true;
    
    end
    
    
    ## - helpers - ##
    
    # safely subtract from the balance and ensure that there will be no negatives
    def subtract_from_balance(amt)
        if(amt >= this.balance)
            this.balance = 0;
            return false;
        else
            this.balance -= amt;
            return true;
        end
    end
    
    # add a given number of shares of a given stock to users inventory
    def addToInventory(stockId, numShares)
       ##TODO## 
    end
    
end
