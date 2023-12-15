# frozen_string_literal: true

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
    def ransackable_attributes(_auth_object = nil)
      %w[description onsale price title]
    end

    def ransackable_associations(_auth_object = nil)
      []
    end
  end

  private

  def set_slug
    self.slug = if slug.present?
                  slug.gsub(/\s/, '-')
                else
                  SecureRandom.alphanumeric[0..10]
                end
  end
end
