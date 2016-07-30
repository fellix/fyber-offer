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
      return [] if error? || no_content?

      body['offers']
    end

    def app_name
      body['information'] && body['information']['app_name']
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
