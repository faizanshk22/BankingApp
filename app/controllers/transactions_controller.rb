class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :access_denied_to_user]
  before_action :access_denied_to_admin, only: [:index, :new]
  before_action :access_denied_to_user, only: [:show]
  
  def index
    sender_transactions = Transaction.joins(account: :user).where(users: { id: current_user.id })
    receiver_transactions = Transaction.where(receiver_id: current_user.accounts.pluck(:id))
    @transactions = sender_transactions.to_a.concat(receiver_transactions.to_a)
  end

  def show
  end

  def new
    @transaction = Transaction.new
    @banks = Bank.distinct
    @sender = current_user
    @receivers = []
    @accounts = @sender.accounts.approved
  end

  
  def create
    @sender_account = Account.find(params[:transaction][:account_id])
    @receiver_account = Account.find(params[:transaction][:receiver_id])
    @transaction = Transaction.new(transaction_params)
    if @transaction.valid?
      if @sender_account.balance.nil? || @transaction.amount > @sender_account.balance
        redirect_to (new_transaction_path), notice: 'Insufficient balance for the transaction.'
        return
      end
      @sender_account.balance -= @transaction.amount
      @receiver_account.balance ||= 0
      @receiver_account.balance += @transaction.amount
      ActiveRecord::Base.transaction do
        @transaction.save!
        @sender_account.save!
        @receiver_account.save!
      end
      redirect_to @transaction, notice: 'Transaction was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
 
  
  def get_users_by_bank
    bank = Bank.find(params[:bank_id])
    @accounts = bank.accounts.excluding(current_user.accounts).approved
    accounts_data = @accounts.pluck(:id, :account_no)
    render json: accounts_data
  end
  
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end



  private
  def access_denied_to_user
    if current_user.admin? || current_user.accounts.exists?(id: @transaction.account_id) || current_user.accounts.exists?(id: @transaction.receiver_id)
    else
      redirect_to root_path, notice: 'Access denied. You can only view your own transactions.'
    end
  end

  def access_denied_to_admin
    if current_user.admin?
      redirect_to root_path
    end
  end  
  def transaction_params
  params.require(:transaction).permit( :amount, :bank_id, :account_id,  :receiver_id)
  end
end
