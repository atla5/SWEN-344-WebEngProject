class User < ActiveRecord::Base
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
    
    
    #add the string for a stockId to private list
    def addFollowing(stockId)
        :stocks_following.push(stockId)
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
end