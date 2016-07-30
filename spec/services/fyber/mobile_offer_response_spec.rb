require 'rails_helper'

describe Fyber::MobileOfferResponse do
  let(:url) { "#{Fyber::MobileOfferRequest::API_URL}.#{Fyber.config.format}" }

  context 'unsuccesfull request' do
    it 'returns error if the request does not return status 200' do
      FakeWeb.register_uri(:get, url,
        body: "{\"code\":\"ERROR_INVALID_TIMESTAMP\",\"message\":\"An invalid or expired timestamp was given as a parameter in the request.\"}",
        status: 400
      )

      subject = described_class.new(HTTPI.get(url))

      expect(subject.error?).to eq true
      expect(subject.error_message).to eq({
        'code' => 'ERROR_INVALID_TIMESTAMP',
        'message' => 'An invalid or expired timestamp was given as a parameter in the request.'
      })
    end

    it 'returns error if the request status is 200 but there is an error code' do
      FakeWeb.register_uri(:get, url,
        body: "{\"code\":\"ERROR_INVALID_APPID\",\"message\":\"An invalid application id (appid) was given as a parameter in the request.\"}"
      )

      subject = described_class.new(HTTPI.get(url))

      expect(subject.error?).to eq true
      expect(subject.error_message).to eq({
        'code' => 'ERROR_INVALID_APPID',
        'message' => 'An invalid application id (appid) was given as a parameter in the request.'
      })
    end
  end

  context 'successful request' do
    it 'returns no offers if there is no content' do
      FakeWeb.register_uri(:get, url,
        body: "{\"code\":\"NO_CONTENT\",\"message\":\"NO_CONTENT\"}"
      )

      subject = described_class.new(HTTPI.get(url))

      expect(subject.success?).to eq true
      expect(subject.offers).to eq []
    end

    it 'returns the offers and informations' do
      FakeWeb.register_uri(:get, url,
        body: File.read("#{Rails.root}/spec/fixtures/successful_response.json")
      )

      subject = described_class.new(HTTPI.get(url))
      expect(subject.success?).to eq true
      expect(subject.offers.size).to eq 1
      expect(subject.app_name).to eq 'SP Test App'
    end
  end
end
