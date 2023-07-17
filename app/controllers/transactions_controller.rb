class TransactionsController < ApplicationController
  def index
   @transactions = current_user.account.transactions
  end

  def show
  end

  def new
    @transaction = Transaction.new
  end

  def create
  @transaction = Transaction.new(transaction_params)
    if @transaction.save
    redirect_to @transaction, notice: 'Transaction was successfully created.'
    else
    render :new
    end
  end




  private
  def transaction_params
  params.require(:transaction).permit(:transaction_type, :amount, :account_id)
  end
end
