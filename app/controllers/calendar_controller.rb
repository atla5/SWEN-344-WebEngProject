class CalendarController < ApplicationController

    def calendar
        #if ! (session['access_token'] && session['access_token_secret'])
            #redirect_to failure_path
        #end
        @user = User.where(handle: "dan_tester344").take
        @events = @user.events
    end
    
    def new_event
    end

end