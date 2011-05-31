module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Base
      def self.mode=(mode)
      end
    end
    class CreditCard
      def initialize(card)
      end
      def valid?
        true
      end
      def display_number
        "1234-56789"
      end
    end
    class Response
      def initialize
      end
      def success?
        true
      end
    end
    class PaypalGateway
      def initialize(card)
      end
      def purchase(arg1, arg2, arg3)
        Response.new
      end
    end
  end
end

