class ProductsController < ApplicationController
  def new
  end

  def create
    product = Product.new(product_params)
    product.save
    redirect_to root_path
  end

  # Strong Parameter
  def product_params
    params.require(:product)
          .permit(:title, :description, :price)
  end
end
