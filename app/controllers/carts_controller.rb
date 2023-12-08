class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, only: [:create]

  def show
  end

  def checkout
    @order = Order.new
  end

  def create
    # 加入購物車
    item = CartItem.new(product: @product, quantity: params[:quantity])
    current_cart.add!(item)

    # 轉商品頁
    redirect_to @product, notice: '成功加入購物車'
  end

  def destroy
    current_cart.destroy
    redirect_to root_path, notice: '購物車已清空'
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end
end
