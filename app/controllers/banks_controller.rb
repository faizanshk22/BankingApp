class BanksController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :require_admin, except: [:index, :show]
  
  def index
    @banks = Bank.all
  end
  def show
    @bank = Bank.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to banks_path, alert: "Bank not found"
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
  def edit
    @bank = Bank.find(params[:id])
  end
  def update
    @bank = Bank.find(params[:id])

    if @bank.update(bank_params)
      redirect_to @bank, notice: "Bank updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bank = Bank.find(params[:id])
    @bank.destroy
    redirect_to banks_path, notice: 'Bank was successfully destroyed.'
  end
  private

  def bank_params
    params.require(:bank).permit(:bank_name)
  end
  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
  
end