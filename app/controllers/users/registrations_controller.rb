# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params
   def new
    @user = User.new
  end

# POST /resource
def create
    @user = User.new(user_params)
  if @user.save
    UserMailer.sample(User.new(email: 'hafeezmalik@isoftstudios.com')).deliver
    redirect_to root_path, notice: 'User created successfully.' 
  else
    render :new
  end
end


  
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end


  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :date_of_birth, :phone, :gender])
   end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
  def after_inactive_sign_up_path_for(resource)
    if resource.is_a?(User)
      flash[:notice] = "Please wait until admin approves your account."
      root_path
    else
      super
    end
  end
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :date_of_birth, :phone, :gender, :header_image)
  end
end
