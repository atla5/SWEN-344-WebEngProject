class CalendarController < ApplicationController

    def calendar
        if ! (session['access_token'] && session['access_token_secret'])
            redirect_to failure_path
        end
        sess = Session.first
        @user = User.where(handle: sess.user).take
        @events = @user.events
    end
    
    def new_event
        sess = Session.first
        currUser = User.where(handle: sess.user).take
        eDate = DateTime.strptime(params[:eventdate], '%Y-%m-%d')
        e = Event.create(user: currUser,
                        start_time: eDate,
                        name: params[:name],
                        location: params[:location])
        e.save
        redirect_to calendar_path
    end
    
end