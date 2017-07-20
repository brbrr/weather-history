require 'rails_helper'

RSpec.describe Observation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'validates' do
    it 'presence of :temperature' do
      observation = Observation.new(pressure: 2, humidity: 3)
      expect(observation.valid?).to be_falsey
      expect(observation.errors.keys).to eq [:temperature]
    end

    it 'presence of :pressure' do
      observation = Observation.new(temperature: 2, humidity: 3)
      expect(observation.valid?).to be_falsey
      expect(observation.errors.keys).to eq [:pressure]
    end

    it 'presence of :humidity' do
      observation = Observation.new(pressure: 2, temperature: 3)
      expect(observation.valid?).to be_falsey
      expect(observation.errors.keys).to eq [:humidity]
    end
  end
end
