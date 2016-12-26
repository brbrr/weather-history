require 'rails_helper'

RSpec.describe Api::ObservationsController, type: :controller do

  describe 'GET #index' do
    let!(:user) { create :user }
    let(:token) { double acceptable?: true, resource_owner_id: user.id }

    before do
      allow(controller).to receive(:doorkeeper_token) {token} # => RSpec 3
    end

    it 'returns http success' do
      get_as_user(:index)
      expect(response).to have_http_status(:success)
    end

    it 'returns last Observation record' do
      5.times { Observation.create(temperature: 1, pressure: 2, humidity: 3 ) }
      all = ActiveModelSerializers::SerializableResource.new(Observation.all, {})

      get_as_user :index
      expect(response.body).to eq all.to_json
    end

    context 'with time_range params' do
      before(:context) do
        @time_1990 = Time.new(1990)
        @time_1970 = Time.new(1970)
        5.times { create :observation, created_at: @time_1990 - 1 }
        5.times { create :observation }
      end

      it 'with to specified' do
        date_range = @time_1970..@time_1990
        serialized_list = ActiveModelSerializers::SerializableResource.new(Observation.where(created_at: date_range), {})
        get :index, params: { time_range: { to: @time_1990.to_i } }, headers: _user_auth_headers
        expect(response.body).to eq serialized_list.to_json
      end

      it 'with from specified' do
        date_range = @time_1990..Time.now
        serialized_list = ActiveModelSerializers::SerializableResource.new(Observation.where(created_at: date_range), {})
        get :index, params: { time_range: { from: @time_1990.to_i } }, headers: _user_auth_headers
        expect(response.body).to eq serialized_list.to_json
      end
    end
  end
end
