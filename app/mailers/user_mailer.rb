class UserMailer < ApplicationMailer

  def login_notify(user)
    @user = user
    mail to: user.email, subject: '登入通知'
  end
end
