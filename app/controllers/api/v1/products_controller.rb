class Api::V1::ProductsController < ApplicationController
  before_action :find_product, only: [:like]
  before_action :authenticate_user!

  def like
    # ....多對多...
    render json: {id: params[:id], status: 'liked'}
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end
end
