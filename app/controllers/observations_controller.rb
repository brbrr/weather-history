class ObservationsController < ApplicationController
  def index
    render json: Observation.all
  end
end
