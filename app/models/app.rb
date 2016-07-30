class App
  include ActiveModel::Model

  attr_accessor :appid, :app_name, :virtual_currency,
    :virtual_currency_sale_enabled, :country, :language, :support_url

  def to_s
    app_name
  end
end
