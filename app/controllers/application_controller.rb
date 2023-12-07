class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  helper_method :current_user, :user_signed_in?, :current_cart

  private

  def current_cart
    if user_signed_in?
      @__cart__ ||= (current_user.cart || current_user.create_cart)
    else
      Cart.new
    end
  end

  def current_user
    # memorization
    @__user__ ||= User.find_by(id: session[:__user_ticket__])
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    if not user_signed_in?
      respond_to do |format|
        format.html {
          redirect_to sign_in_users_path, alert: '請先登入帳號'
        }

        format.json {
          render json: {
            message: '請先登入帳號',
            url: sign_in_users_path
          }, status: 401
        }
      end
    end
  end

  def not_found
    render file: Rails.public_path.join('404.html'),
           status: 404,
           layout: false
  end
end
