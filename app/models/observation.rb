class Observation < ApplicationRecord
  validates :temperature, :pressure, :humidity, presence: true
end
