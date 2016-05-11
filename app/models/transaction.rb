class Transaction < ActiveRecord::Base
    attr_accessible :transaction_date, :transaction_note, :stock_price, :stock_id, :num_shares, :getTransactionAmount;
    
    #general attributes
    belongs_to :user                        #user
    :transaction_note                       #text
    :transaction_date                       #datetime
    
    # - methods - #
    validates_presence_of:stock_id          #string
    validates_presence_of:stock_price       #decimal
    validates_numericality_of:num_shares    #integer
    
    #return the price of the transaction (number of shares * price per share)
    def getTransactionAmount
        return :num_shares * :stock_price
    end
    
    def toString 
        
        #soldOrPurchased = getTransactionAmount>0? "sold" : "bought";
        
        puts :user.name + " sold or purchased " + :num_shares.to_s + 
            " shares of " + :stock_id + " for $" + getTransactionAmount + 
            " at $" + :stock_price.to_s + " per share.";
            
    end
end
