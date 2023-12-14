class Product < ApplicationRecord
  acts_as_paranoid
  acts_as_list scope: :user

  has_one_attached :cover

  has_one_attached :cover do |f|
    f.variant :cover, resize_to_limit: [1000, 1000]
    f.variant :thumb, resize_to_limit: [400, 400]
  end

  # callbacks
  before_validation :set_slug

  # relationships
  belongs_to :user
  has_many :comments, -> { order(id: :desc) }
  has_many :like_products
  has_many :liked_users, through: :like_products, source: :user

  # validations
  validates :title, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :slug, uniqueness: true

  default_scope { where(onsale: true) }

  # class methods
  class << self
    def ransackable_attributes(auth_object = nil)
      ["description", "onsale", "price", "title"]
    end

    def ransackable_associations(auth_object = nil)
      []
    end
  end

  private

  def set_slug
    if self.slug.present?
      self.slug = self.slug.gsub(/\s/, '-')
    else
      self.slug = SecureRandom.alphanumeric[0..10]
    end
  end
end
