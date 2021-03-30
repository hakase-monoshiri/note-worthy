class UserController < ApplicationController

    get "users/sign-up" do

        erb :"user/signup"

    end

    post "/users" do 
        @user = User.find_by(email: params[:user][:email])

        if @user && @user.authenticate(params[:user][:password])
            session[:id] = @user.id
            redirect to "/users/#{@user.id}"
        else
            redirect to "/"
        end
    end


    
    post "/users/new" do

        if params[:password_confirmation] == params[:user][:password]
           @user = User.create(params[:user])
           session[:id] = @user.id
           redirect to "/users/#{@user.id}"
        else
            redirect to "/users/sign-up"
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

    get "/users/:id/edit" do
        if logged_in?
            @user = current_user

            erb :"user/edit"
        else
            redirect to "/"
        end
    end

    post "/users/:id" do
        @user = User.find(params[:id])

        if logged_in? && params[:password_confirmation] == params[:user][:password]
            @user.update(params[:user])
            redirect to "/users/#{@user.id}"
        elsif logged_in?
            redirect to "/users/#{@user.id}/edit"
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