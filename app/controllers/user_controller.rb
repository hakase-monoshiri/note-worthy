class UserController < ApplicationController

    get "/sign-up" do

        erb :"user/signup"

    end
    
    post "/users/new" do

        if params[:password_confirmation] == params[:user][:password]
           @user = User.create(params[:user])
           session[:id] = @user.id
           redirect to "/users/#{@user.id}"
        else
            redirect to "/sign-up"
        end
    end

    get "/users/:id" do
        if logged_in?
            @user = current_user

            erb :"user/show"
        else
            redirect to "/"
        end

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