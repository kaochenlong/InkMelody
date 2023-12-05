class Product < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  has_many :comments, -> { order(id: :desc) }

  has_many :like_products
  has_many :liked_users, through: :like_products, source: :user

  validates :title, presence: true
  validates :price, numericality: { greater_than: 0 }
end
