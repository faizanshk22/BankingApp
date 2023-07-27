class UsersController < ApplicationController
  before_action :to_find_the_user, only: [:show, :edit, :destroy, :create_account_request]
  

  def index
    if user_signed_in?
      @user = current_user
      @banks = Bank.joins(:accounts).where(accounts: { user_id: @user.id, status: 1 }).distinct
      @account_count = @user.accounts.where(status: 1).count
    end
  end

  def show
    if current_user.admin? && params[:id].to_i != current_user.id
    else
      @user = current_user
    end
    rescue ActiveRecord::RecordNotFound
    redirect_to user_path(current_user), alert: "User not found"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: 'User created successfully.' 
    else
      render :new
    end
  end

  def edit
    if current_user.admin? && params[:id].to_i != current_user.id
    else
      @user = current_user
    end
  end

  def update
    @user = current_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'User was successfully deleted.'
  end
  def create_account_request
    @bank = Bank.find(params[:id])
    @account = @bank.accounts.build(user: @user, status: :pending)

    if @account.save
      redirect_to user_path(@user), notice: 'Account creation request sent for approval.'
    else
      redirect_to bank_path(@bank), alert: 'Account creation request failed.'
    end
  end
  def to_find_the_user
    @user = User.find(params[:id])
  end
  def approve
  @user = User.find(params[:id])
  @user.update(approved: true)

  redirect_to admins_index_path, notice: 'User approved successfully.'
  end

  def decline
  @user = User.find(params[:id])
  @user.destroy
  redirect_to admins_index_path, notice: 'User declined successfully.'
  end
  def active_for_authentication?
  super && (approved? || admin?)
  end
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :phone, :gender, :header_image)
  end
end