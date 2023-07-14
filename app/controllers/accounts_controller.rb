class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bank = Bank.find(params[:bank_id])
  @accounts = @bank.accounts.where(user_id: current_user.id)
  end

  def show
    @user = current_user
    @account = Account.find(params[:id])
    @account.bank_id = params[:bank_id]
  end

  def new
    @bank = Bank.find(params[:bank_id])
    @account = Account.new
    
  end

  def create
    @account = current_user.accounts.build(account_params) 
    @account.bank_id = params[:bank_id]
    @account.user = current_user
    if @account.save!
      redirect_to bank_account_path(params[:bank_id],@account.id), notice: 'Account was successfully created.'
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
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to bank_path(params[:bank_id]), notice: 'Account was successfully deleted'
  end
  private

  def account_params
    params.require(:account).permit(:account_no, :balance, :user_id, :bank_id)
  end
end

