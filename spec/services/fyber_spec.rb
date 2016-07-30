require 'rails_helper'

describe Fyber do
  describe '.to_param' do
    it 'returns the config value as a param hash' do
      expect(Fyber.to_param).to eq({
        appid: 157,
        device_id: '2b6f0cc904d137be2e1730235f5664094b83',
        locale: 'de',
        ip: '109.235.143.113',
        offer_types: 112
      })
    end
  end

  describe '.api_key' do
    it 'returns the configured api key' do
      expect(Fyber.api_key).to eq 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'
    end
  end

  describe '.config' do
    it 'returns the default data' do
      expect(Fyber.config.appid).to eq 157
      expect(Fyber.config.format).to eq 'json'
      expect(Fyber.config.device_id).to eq '2b6f0cc904d137be2e1730235f5664094b83'
      expect(Fyber.config.locale).to eq 'de'
      expect(Fyber.config.ip).to eq '109.235.143.113'
      expect(Fyber.config.offer_types).to eq 112
      expect(Fyber.config.api_key).to eq 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'
    end

    it 'allows the config to be set' do
      Fyber.config do |config|
        config.appid = 9999
        config.format = 'xml'
        config.device_id = '123123'
        config.locale = 'br'
        config.ip = '0.0.0.0'
        config.offer_types = 123
        config.api_key = 'xpto'
      end

      expect(Fyber.config.appid).to eq 9999
      expect(Fyber.config.format).to eq 'xml'
      expect(Fyber.config.device_id).to eq '123123'
      expect(Fyber.config.locale).to eq 'br'
      expect(Fyber.config.ip).to eq '0.0.0.0'
      expect(Fyber.config.offer_types).to eq 123
      expect(Fyber.config.api_key).to eq 'xpto'
    end
  end
end
