class UsersController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @banks = Bank.joins(:accounts).where(accounts: { user_id: @user.id, status: 1 }).distinct
      @account_count = @user.accounts.where(status: 1).count
    end
  end

  def show
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    redirect_to user_path(current_user), alert: "User not found"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # @user.approved = false
    if @user.save
      redirect_to root_path, notice: 'User created successfully.' #Waiting for admin approval.'
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: 'User was successfully deleted.'
  end
  def create_account_request
    @user = User.find(params[:id])
    @bank = Bank.find(params[:bank_id])
    @account = @bank.accounts.build(user: @user, status: :pending)

    if @account.save
      redirect_to user_path(@user), notice: 'Account creation request sent for approval.'
    else
      redirect_to bank_path(@bank), alert: 'Account creation request failed.'
    end
  end
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :phone, :gender)
  end
end