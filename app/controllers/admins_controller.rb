class AdminsController < ApplicationController
  before_action :authenticate_admin!
  def index
      @users = User.all
  end
               
  def approve
      user = User.find(params[:id])
      user.update(approved: true)
      redirect_to admin_users_path, notice: 'User approved successfully.'
  end
              
  def decline
      user = User.find(params[:id])
      user.destroy
      redirect_to admin_users_path, notice: 'User declined and removed.'
  end

  private
  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end

end
