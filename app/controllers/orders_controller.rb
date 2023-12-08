class OrdersController < ApplicationController
  include Braintreeable
  before_action :authenticate_user!

  def create
    # 建立訂單
    order = current_user.orders.new(order_params)

    order.order_items = current_cart.cart_items.map do |item|
      product = item.product
      quantity = item.quantity
      price = product.price

      OrderItem.new(product:, quantity:, price:)
    end

    if order.save
      # 請款、刷卡
      nonce = params[:nonce]
      result = braintree_gateway.transaction.sale(
        amount: current_cart.total_amount,
        payment_method_nonce: nonce
      )

      if result.success?
        # 清購物車
        current_cart.destroy

        # 變更訂單狀態
        order.pay!

        redirect_to root_path, notice: '付款成功'
      else
        process_error
      end
    else
      process_error
    end
  end

  private

  def order_params
    params.require(:order)
          .permit(:recipient, :address, :tel)
  end

  def process_error
    redirect_to checkout_cart_path, alert: '系統忙碌中，請稍候再試'
  end
end
