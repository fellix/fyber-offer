require 'digest/sha1'

module Fyber
  class MobileOfferRequest
    API_URL = 'http://api.fyber.com/feed/v1/offers'

    def initialize(uid:, pub0:, page: "1", timestamp: Time.current)
      @uid = uid
      @pub0 = pub0
      @page = page
      @timestamp = timestamp.to_i
    end

    def hashkey
      @hashkey ||= generate_hashkey
    end

    def response
      request = HTTPI::Request.new(request_url)

      MobileOfferResponse.new(HTTPI.get(request))
    end

    private

    attr_reader :uid, :pub0, :page, :timestamp

    def request_url
      params = request_params.merge(hashkey: hashkey).to_query

      url = "#{API_URL}.#{Fyber.config.format}?#{params}"
    end

    def generate_hashkey
      params = request_params.sort.inject([]) do |memo, (key,value)|
        memo << "#{key}=#{value}"
      end

      params << Fyber.api_key

      Digest::SHA1.hexdigest(params.join('&'))
    end

    def request_params
      Fyber.to_param.merge({
        uid: uid,
        pub0: pub0,
        page: page,
        timestamp: timestamp
      })
    end
  end
end
