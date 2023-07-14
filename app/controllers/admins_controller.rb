class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    #@users = User.where(approved: User.approved[:pending]) 
    @users = User.all
  end

  def confirm
    user = User.find(params[:id])
    user.confirmed!
    redirect_to admin_users_path, notice: 'User approved successfully.'
  end

  def decline
    user = User.find(params[:id])
    user.declined!
    redirect_to admin_users_path, notice: 'User declined and removed.'
  end

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path
    end
  end
end

