class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def index
    @users = current_user
    end
    def show
    @user =User.find(params[:id])
    @user =current_user
    rescue ActiveRecord::RecordNotFound
    redirect_to user_path(current_user), alert: "User not found"
    end
    def create
    @user = current_user(user_params)
    if @user.save
       redirect_to @user
    else 
        render :index, status: :unprocessable_entity
    end
    end
    def edit
        @user = current_user
    end
    
    def update
        @user = current_user
        if @user.update(user_params)
          redirect_to user_path(@user), notice: 'Profile updated successfully.'
        else
          render :edit
        end
    end


    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :date_of_birth, :phone, :gender)
    end
end