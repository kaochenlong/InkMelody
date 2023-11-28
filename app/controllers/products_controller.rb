class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @products = Product.order(id: :desc)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      redirect_to root_path, notice: '新增商品成功!!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product), notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path, alert: '商品已刪除'
  end

  private

  # Strong Parameter
  def product_params
    params.require(:product)
          .permit(:title, :description, :price, :onsale)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
