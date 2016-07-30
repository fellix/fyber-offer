require 'rails_helper'

describe Fyber::MobileOfferRequest do
  subject { described_class.new(uid: 'player1', pub0: 'campaign2', page: 2, timestamp: Time.new(2016, 7, 30, 10, 0, 0)) }

  describe '#hashkey' do
    it 'calculates the hashkey' do
      expect(subject.hashkey).to eq '9aa2c5fbd0c17fbf8c87c08892ecfc28248d9016'
    end
  end

  describe '#response' do
    it 'returns a mobile offer response' do
      FakeWeb.register_uri(:get, "#{Fyber::MobileOfferRequest::API_URL}.#{Fyber.config.format}", :body => "Hello World!")

      response = subject.response

      expect(response).to be_a Fyber::MobileOfferResponse
    end
  end
end
