class ProductsController < ApplicationController
  def new
  end

  def create
    # params 寫入資料庫

    redirect_to root_path
  end
end
