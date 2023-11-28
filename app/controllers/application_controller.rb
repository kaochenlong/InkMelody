class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  helper_method :current_user, :user_signed_in?

  private

  def current_user
    User.find_by(id: session[:__user_ticket__])
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    if not user_signed_in?
      redirect_to sign_in_users_path, alert: '請先登入帳號'
    end
  end

  def not_found
    render file: Rails.public_path.join('404.html'),
           status: 404,
           layout: false
  end
end
