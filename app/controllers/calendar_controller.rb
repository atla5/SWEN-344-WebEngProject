class CalendarController < ApplicationController

    def calendar
        #if ! (session['access_token'] && session['access_token_secret'])
            #redirect_to failure_path
        #end
        @user = User.where(handle: client.user.screen_name).take
        @events = @user.events
        
    end 
    

    def new_event
        currUser = User.where(handle: client.user.screen_name).take
        eDate = DateTime.strptime(params[:eventdate], '%Y-%m-%d')
        e = Event.create(user: currUser,
                        start_time: eDate,
                        name: params[:name],
                        location: params[:location])
        e.save
        redirect_to calendar_path
    end
    
    
end