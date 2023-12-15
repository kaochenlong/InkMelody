# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  around_action :switch_locale
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized
  helper_method :current_user, :user_signed_in?, :current_cart

  private

  def default_url_options
    { lang: I18n.locale }
  end

  def switch_locale(&)
    lang = params[:lang] || I18n.default_locale
    I18n.with_locale(lang, &)
  end

  def current_cart
    if user_signed_in?
      @__cart__ ||= current_user.cart || current_user.create_cart
    else
      Cart.new
    end
  end

  def current_user
    # memorization
    @current_user ||= User.find_by(id: session[:__user_ticket__])
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    return if user_signed_in?

    respond_to do |format|
      format.html do
        redirect_to sign_in_users_path, alert: '請先登入帳號'
      end

      format.json do
        render json: { message: '請先登入帳號', url: sign_in_users_path }, status: 401
      end
    end
  end

  def not_found
    render file: Rails.public_path.join('404.html'),
           status: 404,
           layout: false
  end

  def not_authorized
    redirect_to root_path, alert: '權限不足'
  end
end
