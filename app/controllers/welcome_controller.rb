class WelcomeController < ApplicationController
  # GET /welcome
  def index
     if session['access_token'] && session['access_token_secret']
       redirect_to show_path
     end
  end

end
