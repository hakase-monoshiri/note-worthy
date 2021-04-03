require './config/environment'
require "rack-flash"
require 'securerandom'

class ApplicationController < Sinatra::Base

  SECRET = SecureRandom.hex(16)

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') {SecureRandom.hex(64)}
  end 

  get "/" do

    erb :index
  end

       
  helpers do
        
    def current_user
      if logged_in?
        User.find(session[:id])
      end
    end
  
    def logged_in?
        !!session[:id] 
    end

  end

end
