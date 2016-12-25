require 'rails_helper'


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
