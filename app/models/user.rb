# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  has_one :cart
  has_many :products, -> { order(position: :asc) }
  has_many :comments
  has_many :orders

  has_many :like_products
  has_many :liked_products, through: :like_products, source: :product

  before_create :encrypt_password

  def self.login(data)
    email = data[:email]
    password = Digest::SHA256.hexdigest("*xx#{data[:password]}yy-")

    find_by(email:, password:)
  end

  def own?(prod)
    products.unscope(where: :onsale).include?(prod)
  end

  def liked?(prod)
    liked_product_ids.include?(prod.id)
  end

  private

  def encrypt_password
    salted_password = "*xx#{password}yy-"
    self.password = Digest::SHA256.hexdigest(salted_password)
  end
end
