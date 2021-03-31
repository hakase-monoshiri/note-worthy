require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "idontknowhowtomakesecretsessioncodes"
  end 

  get "/" do
    erb :index
  end

       
  helpers do
        
    def current_user
        User.find(session[:id])
    end
  
    def logged_in?
        !!session[:id] 
    end

  end

end
