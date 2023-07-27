class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show]

  def index
    @transactions = Transaction.joins(:account).where(accounts: { user_id: current_user.id })
  end

  def show
  end

  def new
    @transaction = Transaction.new
    @banks = Bank.distinct
    @sender = current_user
    @receivers = []
    @accounts = @sender.accounts
    
    #@receivers = User.where.not(id: @sender.id).where(admin: false)
  end

  
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.account_id = @transaction.sender_id
    @sender_account = Account.find(params[:transaction][:sender_id])
    @receiver_account = Account.find(params[:transaction][:receiver_id])
      if @transaction.valid?
      if @sender_account.balance.nil? || @transaction.amount > @sender_account.balance
        flash.now[:alert] = 'Insufficient balance for the transaction.'
        render :new, status: :unprocessable_entity
        return
      end

      @sender_account.balance -= @transaction.amount
      @receiver_account.balance += @transaction.amount if @receiver_account.balance ||= 0

    end

    if @transaction.save
      @sender_account.save
      @receiver_account.save
      redirect_to @transaction, notice: 'Transaction was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def get_users_by_bank
    bank = Bank.find(params[:bank_id])
    @accounts = bank.accounts.excluding(current_user.accounts)
    accounts_data = @accounts.pluck(:id, :account_no)
    render json: accounts_data
  end
  
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end



  private
  def transaction_params
  params.require(:transaction).permit( :amount, :bank_id, :sender_id,  :receiver_id)
  end
end
