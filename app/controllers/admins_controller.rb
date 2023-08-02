class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    #@users = User.where(approved: false) 
    @users = User.all
  end
  

  def approve_account
    account = Account.find(params[:id])
  account.update(status: 'approved')
  redirect_to admins_index_path, notice: 'Account approved successfully.'
  end
  def decline_account
    account = Account.find(params[:id])
    account.update(status: 'declined')
    redirect_to admins_index_path, notice: 'Account declined successfully.'
  end
  def account_requests
    @pending_accounts = Account.pending.includes(:user, :bank)
  end
  #def show
   # @admin = current_user
  #end
  #def edit
   # @user = User.find(params[:id])
   # redirect_to edit_user_path(@user) unless current_user == @user
  #end
 

  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path
    end
  end
end

