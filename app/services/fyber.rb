require 'ostruct'

module Fyber
  @@settings = OpenStruct.new(format: 'json')

  class << self
    delegate :method_missing,to: :config

    def config(&block)
      yield @@settings if block_given?

      @@settings
    end

    def to_param
      {
        appid: config.appid,
        device_id: config.device_id,
        locale: config.locale,
        ip: config.ip,
        offer_types: config.offer_types
      }
    end

    def api_key
      config.api_key
    end
  end
end
