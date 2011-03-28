# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def test_payment

    # Use the TrustCommerce test servers
    ActiveMerchant::Billing::Base.mode = :test

    # ActiveMerchant accepts all amounts as Integer values in cents
    # $10.00
    amount = 1000

    # The card verification value is also known as CVV2, CVC2, or CID
    credit_card = ActiveMerchant::Billing::CreditCard.new(
      :first_name         => 'Bob',
      :last_name          => 'Bobsen',
      :number             => '4242424242424242',
      :month              => '8',
      :year               => '2012',
      :verification_value => '123'
    )

    # Validating the card automatically detects the card type
    if credit_card.valid?

      # Create a gateway object for the TrustCommerce service
      gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
        :login => 'TestMerchant',
        :password => 'password'
      )

      # Authorize for the amount
      response = gateway.purchase(amount, credit_card)

      if response.success?
        puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
      else
        raise StandardError, response.message
      end
    end

  end
end
