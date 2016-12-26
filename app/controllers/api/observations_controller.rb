class Api::ObservationsController < Api::BaseController
  before_action :authenticate_user!

  def index
    render json: Observation.where(created_at: date_range(user_params))
  end

  private

  def user_params
    params.require(:time_range).permit(:from, :to) if params[:time_range]
  end

  def date_range(params)
    from = params&.dig(:from) ? Time.at(params[:from].to_i) : Time.new(1970)
    to = params&.dig(:to) ? Time.at(params[:to].to_i) : Time.now
    from..to
  end
end
