class Stock < ActiveRecord::Base
    attr_accessible :numShares, :stockId;
    
    belongs_to :user
    
    validates_numericality_of :numShares    #integer
    validates_presence_of :stockId          #string
    
end
