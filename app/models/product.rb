class Product < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  has_many :comments, -> { order(id: :desc) }

  validates :title, presence: true
  validates :price, numericality: { greater_than: 0 }
end
