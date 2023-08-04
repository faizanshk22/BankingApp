# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def sample
        UserMailer.sample(User.new(email: 'hafeezmalik@isoftstudios.com'))
    end

end
