class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update]
  before_action :access_denied_to_admin, only: [:index, :new]
  before_action :access_denied_to_user, only: [:show, :edit]
  def index
    @accounts = current_user.accounts
  end

  def show
  end

  def new
    @account = Account.new  
  end

  def create
    @account = Account.new(account_params)
    @account.user = current_user
    @account.status = :pending
    if @account.save
      redirect_to account_path(@account), notice: 'Account was successfully created. Please wait for account approval'
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def edit
    @user = @account.user
  end

  def update
    if @account.update(account_params)
      redirect_to account_path(@account), notice: 'Account was successfully updated.'
    else
      render :edit 
    end
  end
  def destroy
    account = Account.find(params[:id])
    account.destroy
    redirect_to root_path, notice: 'Account successfully cancelled.'
  end  
  
  private
  def access_denied_to_user
    if current_user == @account.user || current_user.admin?
    else
      redirect_to root_path, alert: "You are not authorized to view this account."
    end
  end
  def access_denied_to_admin
    if current_user.admin?
      redirect_to root_path
    end
  end  
  def set_account
    @account = Account.find(params[:id])
  end
  def account_params
    params.require(:account).permit(:account_no, :balance, :user_id, :bank_id)
  end
end

