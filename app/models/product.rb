class Product < ApplicationRecord
  acts_as_paranoid
  acts_as_list scope: :user

  has_one_attached :cover

  has_one_attached :cover do |f|
    f.variant :cover, resize_to_limit: [1000, 1000]
    f.variant :thumb, resize_to_limit: [400, 400]
  end

  belongs_to :user
  has_many :comments, -> { order(id: :desc) }

  has_many :like_products
  has_many :liked_users, through: :like_products, source: :user

  validates :title, presence: true
  validates :price, numericality: { greater_than: 0 }

  default_scope { where(onsale: true) }

  def self.ransackable_attributes(auth_object = nil)
    ["description", "onsale", "price", "title"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
