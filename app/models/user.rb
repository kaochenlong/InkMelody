class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  has_many :products
  has_many :comments

  before_create :encrypt_password

  def self.login(data)
    email = data[:email]
    password = Digest::SHA256.hexdigest("*xx#{data[:password]}yy-")

    # find_by(email: email, password: password)
    find_by(email:, password:)
  end

  def own?(p)
    product_ids.include?(p.id)
  end

  private

  def encrypt_password
    salted_password = "*xx#{self.password}yy-"
    self.password = Digest::SHA256.hexdigest(salted_password)
  end
end
