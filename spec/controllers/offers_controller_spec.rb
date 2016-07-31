require 'rails_helper'

describe OffersController do
  describe 'GET #index' do
    it 'returns success' do
      get :index

      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'failed requests' do
      it 'returns error when the uid is not given' do
        post :create

        expect(flash[:alert]).to eq 'uid is required'
        expect(response).to render_template :index
      end

      it 'returns error if the request response is not successful' do
        failed_response = double('FailedResponse', error?: true, error_message: 'Something went wrong')
        allow_any_instance_of(Fyber::MobileOfferRequest).to receive(:response).and_return failed_response

        post :create, params: { uid: 'player1' }

        expect(flash[:alert]).to eq 'Unable to process your request Something went wrong'
        expect(response).to render_template :index
      end
    end

    context 'successful requests' do
      it 'renders the view with the processed data' do
        successful_response = double('SuccessfulResponse', error?: false, app: App.new(app_name: 'Sample'), offers: [Offer.new(title: 'Offer Sample')])
        allow_any_instance_of(Fyber::MobileOfferRequest).to receive(:response).and_return successful_response

        post :create, params: { uid: 'player1' }

        expect(response).to be_success
      end
    end
  end
end
