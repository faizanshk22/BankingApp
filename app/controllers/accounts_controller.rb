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
    @bank = Bank.find(params[:bank_id])
    @account = current_user.accounts.build(account_params) 
    #@account = @bank.accounts.build(account_params)
    @account.user = current_user

    if @account.save
      redirect_to account_path(@account), notice: 'Account was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def account_params
    params.require(:account).permit(:account_no, :balance, :user_id)
  end
end

