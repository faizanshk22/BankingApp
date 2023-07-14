class UsersController < ApplicationController
  def index
    @users = current_user
  end

  def show
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    redirect_to user_path(current_user), alert: "User not found"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'User created successfully.' #Waiting for admin approval.'
    else
      render :new
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

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :phone, :gender)
  end
end