class Api::V1::ProductsController < ApplicationController
  before_action :find_product, only: [:like]
  before_action :authenticate_user!

  def like
    if current_user.liked?(@product)
      current_user.liked_products.destroy(@product)
      render json: {id: params[:id], status: 'unliked'}
    else
      current_user.liked_products << @product
      render json: {id: params[:id], status: 'liked'}
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end
end
