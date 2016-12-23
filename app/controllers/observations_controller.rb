class ObservationsController < ApplicationController
  def index
    render json: Observation.last
  end
end
