class ObservationSerializer < ActiveModel::Serializer
  attributes :id, :temperature, :preasure, :humidity, :created_at
end
