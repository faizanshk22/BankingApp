class BanksController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :require_admin, except: [:index, :show]
  before_action :to_find_bank, only: [:show, :edit, :update, :destroy]
  
  def index
    @banks = Bank.all
  end
  def show
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
  rescue ActiveRecord::RecordNotFound
    redirect_to banks_path, alert: "Bank not found"
  end
  def update
    if @bank.update(bank_params)
      redirect_to @bank, notice: "Bank updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bank.destroy
    redirect_to banks_path, notice: 'Bank was successfully destroyed.'
  end

  def to_find_bank
    @bank = Bank.find(params[:id])
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