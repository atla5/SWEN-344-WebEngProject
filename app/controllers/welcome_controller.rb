class WelcomeController < ApplicationController
  # GET /welcome
  def index
     @authUrl = ENV['AUTH_URL']
     @loggedIn = false
     if session['access_token'] && session['access_token_secret']
       @loggedIn = true
       redirect_to show_path
     end
  end

end
