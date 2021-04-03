class UserController < ApplicationController

    use Rack::Flash

    get "/users/new" do

        erb :"user/signup"

    end

    get "/users/sign-out" do

        session.clear
        flash[:message] = "You have successfully signed out."

        redirect to "/"
    end

    post "/users" do 
        @user = User.find_by(email: params[:user][:email])

        if @user && @user.authenticate(params[:user][:password])
            session[:id] = @user.id
            redirect to "/users/#{@user.id}"
        else
            flash[:message] = "Whoops! Looks like we couldn't find that email/password combination."
            redirect to "/"
        end
    end


    
    post "/users/new" do
        if User.find_by(email: params[:user][:email])

            flash[:message] = "That user already exists. Please Log-in."
            redirect to "/"
        elsif params[:password_confirmation] == params[:user][:password]
           @user = User.create(params[:user])
           session[:id] = @user.id
           redirect to "/users/#{@user.id}"
        else
            flash[:message] = "Sorry, looks like there was an error on the sign-up page. Please try again."
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
        session.clear

        redirect to "/"
    end


end
