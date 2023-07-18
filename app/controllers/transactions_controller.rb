class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show]

  def index
   @transactions = Transaction.all
  end

  def show
  end

  def new
    @transaction = Transaction.new
    @accounts = current_user.accounts
  end

  
  def create
    @transaction = Transaction.new(transaction_params)
    @account = Account.find(params[:transaction][:account_id]) 
  
    if @transaction.valid? && @account.present?
      if @transaction.deposit?
        @account.balance ||= 0
        @account.balance += @transaction.amount
      elsif @transaction.withdrawal?
        if @account.balance.nil? || @transaction.amount > @account.balance
          flash.now[:alert] = 'Insufficient balance for withdrawal.'
          render :new, status: :unprocessable_entity
          return
        else
          @account.balance -= @transaction.amount
        end
      end
    end
  
    if @transaction.errors.empty? && @transaction.save
      @account.save
      redirect_to @transaction, notice: 'Transaction was successfully created.'
    else
      flash.now[:alert] = @transaction.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity, turbo_frame: 'transaction-form'
    end
  end
  
  
  
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end



  private
  def transaction_params
  params.require(:transaction).permit(:transaction_type, :amount, :account_id)
  end
end
