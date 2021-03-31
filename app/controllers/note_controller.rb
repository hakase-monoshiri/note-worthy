class NoteController < ApplicationController

    get "/notes/new" do

        erb :"note/new"
    end

    post "/notes/new" do
        @user = current_user
        @note = Note.create(params[:note])

        if @user   
            @user.notes << @note

            redirect to "/users/#{@user.id}"
        else
            redirect to "/"
        end

    end

    get "/notes/:id" do
        if logged_in?
            @note = current_user.notes.find(params[:id])
        else
            redirect to "/"
        end

        if @note
            erb :"note/show"
        else
            erb :"note/error"
        end
    end

    get "/notes/:id/edit" do
        if logged_in?
            @note = current_user.notes.find(params[:id])
        else
            redirect to "/"
        end

        if @note
            erb :"note/edit"
        else
            erb :"note/error"
        end
    end

    patch "/notes/:id" do
        if logged_in?
            @note = current_user.notes.find(params[:id])
        else
            erb :"user/error"
        end

        if @note
            @note.update(params[:note])
            redirect to "/notes/#{@note.id}"
        else
            erb :"note/error"
        end
    end

    





end
