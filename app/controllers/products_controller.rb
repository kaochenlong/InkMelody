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

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to product_path(@product), notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to root_path, alert: '商品已刪除'
  end

  # Strong Parameter
  def product_params
    params.require(:product)
          .permit(:title, :description, :price)
  end
end
