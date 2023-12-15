# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  # 委任 delegate
  delegate :count, to: :cart_items

  def total_amount
    cart_items.reduce(0) do |acc, item|
      acc + (item.product.price * item.quantity)
    end.to_i
  end

  def add!(item)
    found_item = cart_items.find { |i| i.product == item.product }

    if found_item
      found_item.increment!(:quantity, item.quantity)
    else
      cart_items << item
    end
  end
end
