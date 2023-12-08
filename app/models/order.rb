class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  validates :recipient, :address, :tel, presence: true
  validates :serial, uniqueness: true

  before_create :generate_serial

  private

  def generate_serial
    self.serial = serial_generator
  end

  def serial_generator(n = 6)
    now = Time.current
    year = now.year
    month = "%02d" % now.month
    day = "%02d" % now.day
    code = SecureRandom.alphanumeric.upcase[0..n - 1]

    "IM#{year}#{month}#{day}#{code}"
  end
end
