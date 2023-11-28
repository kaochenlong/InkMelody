class Product < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  validates :title, presence: true
  validates :price, numericality: { greater_than: 0 }
end
