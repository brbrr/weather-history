require 'rails_helper'

RSpec.describe ObservationsController, type: :controller do
  describe "GET #index" do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns last Observation record' do
      5.times { Observation.create(temperature: 1, pressure: 2, humidity: 3 ) }
      all = ActiveModelSerializers::SerializableResource.new(Observation.all, {})

      get :index
      expect(response.body).to eq all.to_json
    end
  end
end
