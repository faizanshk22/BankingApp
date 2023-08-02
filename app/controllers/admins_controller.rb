class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.where(admin: false)
  end
  

  def approve_account
  account = Account.find(params[:id])
  account.update(status: 'approved')
  redirect_to admins_index_path, notice: 'Account approved successfully.'
  end
  def decline_account
    account = Account.find(params[:id])
    account.destroy
    redirect_to admins_index_path, notice: 'Account declined successfully.'
  end
  def pending
    @users = User.where(approved: false)
  end
 

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path
    end
  end
end

