class User < ActiveRecord::Base
    validates :handle,
              presence: true,
              length: { minimum: 2 },
              uniqueness: true
              
    validates_numericality_of :zip
    validates_numericality_of :tweets_count
    validates_numericality_of :followers_count
    validates_presence_of :name
    has_many :transactions
    has_many :events
end
