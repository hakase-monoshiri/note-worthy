class UserController < ApplicationController

    get "users/new" do

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
            redirect to "/users/new"
        end
    end

    get "/users/:id" do
        if logged_in?
            @user = current_user

            erb :"user/show"
        else
            erb :"user/error"
        end

    end



    get "/users/:id/edit" do
        if logged_in?
            @user = current_user

            erb :"user/edit"
        else
            erb :"user/error"
        end
    end

    get "/users/:id/delete" do
        if logged_in?
            @user = current_user

            erb :"user/delete"
        else
            erb :"user/error"
        end

    end
    


    patch "/users/:id" do
        @user = User.find(params[:id])

        if logged_in? && params[:password_confirmation] == params[:user][:password]
            @user.update(params[:user])
            redirect to "/users/#{@user.id}"
        elsif logged_in?
            redirect to "/users/#{@user.id}/edit"
        else
            erb :"user/error"
        end
    end

    
    delete "/users/:id" do
        @user = User.find(params[:id])
        @user.destroy

        redirect to "/"
    end


end
