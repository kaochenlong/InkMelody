class ProductsController < ApplicationController
  def index
    @products = Product.all.order(id: :desc)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to root_path, notice: '新增商品成功!!'
    else
      # 借 app/views/products/new.html.erb
      render :new
    end
  end

  # Strong Parameter
  def product_params
    params.require(:product)
          .permit(:title, :description, :price)
  end
end
