class ObservationSerializer < ActiveModel::Serializer
  attributes :id, :temperature, :pressure, :humidity, :created_at
end
