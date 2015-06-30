class UserMailer < ActionMailer::Base
  default from: "Dental Partner <no_reply@dentalpartner.com>"

  def send_credentials_email(user)
    @user  = user
    @email = user.email
    mail to: @email, subject: "Dental Partner Account Details"
  end

  def import_status(method, invalid_records)
    @invalid_records = invalid_records
    @method          = method
    @admin           = User.admin
    mail to: @admin.email, cc: 'drewhankin@azurigroup.com.au', bcc: 'shreya.freedom@gmail.com' ,subject: "Dental Partner | User CSV Import Status"
  end
end
