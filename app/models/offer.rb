class Offer
  include ActiveModel::Model

  attr_accessor :offer_id, :title, :teaser, :required_actions, :link,
    :offer_types, :payout, :time_to_payout, :thumbnail, :store_id

  def to_s
    title
  end
end
