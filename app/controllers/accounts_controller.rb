class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = current_user.accounts
  end

  def show
    @user = current_user
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    @account.user = current_user
    @account.status = :pending
    if @account.save
      redirect_to account_path(@account), notice: 'Account was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
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

  def account_params
    params.require(:account).permit(:account_no, :balance, :user_id, :bank_id)
  end
end

