class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  # 委任 delegate
  delegate :count, to: :cart_items

  def total_amount
    cart_items.reduce(0) do |acc, item|
      acc + (item.product.price * item.quantity)
    end.to_i
  end

  def add!(t)
    found_item = cart_items.find { |item| item.product == t.product }

    if found_item
      found_item.increment!(:quantity, t.quantity)
    else
      cart_items << t
    end
  end
end
