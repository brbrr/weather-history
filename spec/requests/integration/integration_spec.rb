require 'rails_helper'

RSpec.describe 'Integration Use Case' do
  it 'creates new user and gets all the Observations' do
    5.times { create :observation }
    register('some_email@test.com', 'password')
    sign_in('some_email@test.com', 'password')
    authenticate('some_email@test.com', 'password')
    get_as_user('/api/observations')

    all = ActiveModelSerializers::SerializableResource.new(Observation.all, {})
    expect(json.to_json).to eq all.to_json
  end
end
