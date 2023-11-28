class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    comment = product.comments.new(comment_params)

    if comment.save
      redirect_to product_path(product), notice: '新增留言成功'
    else
      redirect_to product_path(product), alert: '留言發生錯誤'
    end
  end

  private

  def comment_params
    params.require(:comment)
          .permit(:content)
          .merge(user: current_user)
  end
end
