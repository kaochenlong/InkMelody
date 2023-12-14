class ProductsController < ApplicationController
  before_action :find_product, only: [:show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_owned_product, only: [:edit, :update, :destroy]

  def index
    authorize :product

    @products = Product.includes(:user)
                       .order(id: :desc)
                       .page(params[:page])
                       .per(8)
  end

  def show
    authorize @product

    @comment = Comment.new
    @comments = @product.comments
  end

  def my
    authorize :product

    @products = current_user.products
                            .unscope(where: :onsale)
                            .page(params[:page])
                            .per(8)
  end

  def search
    authorize :product

    data = Product.ransack(title_or_description_cont: params[:q])
    @products = data.result
  end

  def new
    @product = Product.new

    authorize @product
  end

  def create
    @product = current_user.products.new(product_params)

    authorize @product

    if @product.save
      redirect_to my_products_path, notice: '新增商品成功!!'
    else
      render :new
    end
  end

  def edit
    authorize @product
  end

  def update
    authorize @product

    if @product.update(product_params)
      redirect_to my_products_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    authorize @product

    @product.destroy
    redirect_to root_path, alert: '商品已刪除'
  end

  private

  # Strong Parameter
  def product_params
    params.require(:product)
          .permit(:title, :description, :price, :onsale, :cover, :publish_date)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def find_owned_product
    @product = Product.unscope(where: :onsale)
                      .find(params[:id])
  end
end
