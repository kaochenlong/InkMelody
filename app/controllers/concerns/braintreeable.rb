module Braintreeable
  def braintree_gateway
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: '',
      public_key: '',
      private_key: '',
    )
  end
end
