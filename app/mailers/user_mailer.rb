class UserMailer < ApplicationMailer
  default from: 'faizanshk20ucp.edu.pk'

  def sample(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Online Banking App!')
  end
end
