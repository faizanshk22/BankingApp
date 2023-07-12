class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
    if params[:approved] == "false"
    @users = User.where(approved: false)
    else
    @users = current_user
    end
  
    def show
      @user = User.find(params[:id])
    end
  
    def edit
    end
  
    def update
    end
  
    def destroy
    end
  
    private
    def user_params
      params.require(:user).permit(:first_name,:last_name, :date_of_birth, :phone, :gender)
    end
    def require_admin
        if current_user.role.name != 'admin'
            redirect_to root_path, :flash => { :error => "You need admin permision to perform this action!" }
        end
    end
end
