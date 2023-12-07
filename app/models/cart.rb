class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  # 委任 delegate
  delegate :count, to: :cart_items

  def add!(t)
    found_item = cart_items.find { |item| item.product == t.product }

    if found_item
      found_item.increment!(:quantity, t.quantity)
    else
      cart_items << t
    end
  end
end
