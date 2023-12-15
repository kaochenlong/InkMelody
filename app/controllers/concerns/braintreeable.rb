# frozen_string_literal: true

module Braintreeable
  def braintree_gateway
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV.fetch('BRAINTREE_MERCHANT_ID', nil),
      public_key: ENV.fetch('BRAINTREE_PUBLIC_KEY', nil),
      private_key: ENV.fetch('BRAINTREE_PRIVATE_KEY', nil)
    )
  end
end
