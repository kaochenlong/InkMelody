# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    current_cart.cart_items.find(params[:id]).destroy
    redirect_to cart_path, notice: '購物車已更新'
  end
end
