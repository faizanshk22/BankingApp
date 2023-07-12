class BanksController < ApplicationController
  def index
    @banks = Bank.all
  end
  
  def show
    @bank = Bank.find(params[:id])
  end

  def new
    @bank = Bank.new
  end

  def create
    @bank = Bank.new(bank_params)
    if @bank.save
      redirect_to @bank
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bank_params
    params.require(:bank).permit(:bank_name)
  end
end
