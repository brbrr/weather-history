class Api::ObservationsController < Api::BaseController
  before_action :authenticate_user!

  def index
    render json: Observation.all
  end
end
