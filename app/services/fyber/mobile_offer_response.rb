module Fyber
  class MobileOfferResponse
    def initialize(httpi_response)
      @httpi_response = httpi_response
    end

    def error?
      httpi_response.error? || body_error?
    end

    def success?
      !error?
    end

    def error_message
      return if success?

      body
    end

    def offers
      return [] if error? || no_content? || !body.has_key?('offers')

      body['offers'].map do |offer_data|
        Offer.new(offer_data)
      end
    end

    def app
      return if !body.has_key?('information')

      App.new(body['information'])
    end

    private

    def body
      @body ||= JSON.parse(httpi_response.body)
    end

    attr_reader :httpi_response

    def no_content?
      body['code'] && body['code'] == 'NO_CONTENT'
    end

    def body_error?
      body['code'] && body['code'].include?('ERROR')
    end
  end
end
