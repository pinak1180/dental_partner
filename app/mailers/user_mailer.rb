class UserMailer < ActionMailer::Base
  default from: "Dental Partner <no_reply@dentalpartner.com>"

  def send_credentials_email(user)
    @user  = user
    @email = user.email
    mail to: @email, subject: "Dental Partner Account Details"
  end
end
