require 'rails_helper'

# RSpec.describe ObservationsController, type: :controller do
#   describe "GET #index" do
#     it 'returns http success' do
#       get :index
#       expect(response).to have_http_status(:success)
#     end
#
#     it 'returns last Observation record' do
#       5.times { Observation.create(temperature: 1, pressure: 2, humidity: 3 ) }
#       all = ActiveModelSerializers::SerializableResource.new(Observation.all, {})
#
#       get :index
#       expect(response.body).to eq all.to_json
#     end
#   end
# end

RSpec.describe 'API Observations' do
  describe 'GET /api/observations' do
    let!(:user) { create :user }

    it 'returns all Observations' do
      5.times { create :observation }
      all = ActiveModelSerializers::SerializableResource.new(Observation.all, {})
      get_as_user '/api/observations'
      expect(json.to_json).to eq all.to_json
      expect(response.status).to eq 200
    end
  end
end
