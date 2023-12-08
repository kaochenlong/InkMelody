class Order < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :order_items

  validates :recipient, :address, :tel, presence: true
  validates :serial, uniqueness: true

  before_create :generate_serial

  # state machine
  aasm column: 'state', no_direct_assignment: true do
    state :pending, initial: true
    state :paid, :delivered, :cancelled, :refunded

    event :pay do
      transitions from: :pending, to: :paid

      # after do
      #   puts "發送簡訊"
      # end
    end

    event :deliver do
      transitions from: :paid, to: :delivered
    end

    event :cancel do
      transitions from: [:pending, :paid], to: :cancelled
    end
  end

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
