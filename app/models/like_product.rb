# frozen_string_literal: true

class LikeProduct < ApplicationRecord
  belongs_to :user
  belongs_to :product
end
