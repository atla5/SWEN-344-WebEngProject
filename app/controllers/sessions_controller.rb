class SessionsController < ApplicationController
  def create
    credentials = request.env['omniauth.auth']['credentials']
    session[:access_token] = credentials['token']
    session[:access_token_secret] = credentials['secret']
    redirect_to show_path, notice: 'Signed in'
  end

  def show
    if session['access_token'] && session['access_token_secret']
      @user = client.user(include_entities: true)
      @tweets = client.home_timeline[0..10]
      @forecast = weather.lookup_by_woeid(12763350)
    else
      redirect_to failure_path
    end
  end
  
  def writetweet
    if session['access_token'] && session['access_token_secret']
      @tweet = params[:tweet]
      client.update(@tweet)
      redirect_to show_path
    else
      redirect_to failure_path
    end
  end

  def error
    flash[:error] = 'Sign in with Twitter failed'
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Signed out'
  end
end
