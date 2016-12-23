require 'rails_helper'

RSpec.describe ObservationsController, type: :controller do
  describe "GET #index" do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns last Observation record' do
      observation = Observation.create
      get :index
      expect(response.body).to eq observation.to_json
    end
  end
end
