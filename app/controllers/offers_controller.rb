class OffersController < ApplicationController
  def create
    if params[:uid].blank?
      flash[:alert] = "uid is required"

      return render :index
    end

    response = Fyber::MobileOfferRequest.new(
      uid: params[:uid],
      pub0: params[:pub0],
      page: params[:page]
    ).response

    if response.error?
      flash[:alert] = "Unable to process your request #{response.error_message}"

      return render :index
    end

    @app = response.app
    @offers = response.offers
  end
end
