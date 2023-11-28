class SessionsController < ApplicationController
  def create
    user = User.login(params[:user])

    if user
      session[:__user_ticket__] = user.id
      redirect_to root_path, notice: '登入成功'
    else
      redirect_to sign_in_users_path, alert: '登入失敗'
    end
  end

  def destroy
    session.delete(:__user_ticket__)
    redirect_to root_path, notice: '已登出'
  end
end
