class UserMailer < ActionMailer::Base
  default from: "Maven Dental Link <noreply@mavendentallink.com.au>"

  def send_credentials_email(user)
    @user  = user
    @email = user.email
    mail to: @email, subject: "Maven Dental Link Account Details"
  end

  def import_status(method, invalid_records)
    @invalid_records = invalid_records
    @method          = method
    @admin           = User.admin
    mail to: @admin.email, cc: 'drewhankin@azurigroup.com.au', bcc: 'shreya.freedom@gmail.com' ,subject: "Maven Dental Link | User CSV Import Status"
  end
end
