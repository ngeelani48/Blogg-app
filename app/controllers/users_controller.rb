class UsersController < ApplicationController
    def show
        @user_id = params[:id]
    end

    def index
        @user = User.all
    end
end