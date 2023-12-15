# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      before_action :find_product, only: [:like]
      before_action :find_user_product, only: [:sort]
      before_action :authenticate_user!

      def like
        if current_user.liked?(@product)
          current_user.liked_products.destroy(@product)
          render json: { id: params[:id], status: 'unliked' }
        else
          current_user.liked_products << @product
          render json: { id: params[:id], status: 'liked' }
        end
      end

      def sort
        @product.insert_at(params[:newIndex] + 1)
        render json: { id: @product.id }
      end

      private

      def find_product
        @product = Product.find(params[:id])
      end

      def find_user_product
        @product = current_user.products.unscope(:where).find(params[:id])
      end
    end
  end
end
