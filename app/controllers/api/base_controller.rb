class Api::BaseController < ApplicationController
  # include CanCan::ControllerAdditions

  clear_respond_to
  respond_to :json

  before_action :doorkeeper_authorize!
  before_action :authenticate_user!

  # check_authorization unless: :devise_controller?

  # rescue_from CanCan::AccessDenied do |e|
  #   render json: errors_json(e.message), status: :forbidden
  # end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: errors_json(e.message), status: :not_found
  end

  private

  def authenticate_user!
    if doorkeeper_token
      current_user = User.find(doorkeeper_token.resource_owner_id)
    end

    return if current_user

    render json: errors_json('User is not authenticated!'), status: :unauthorized
  end

  def current_user
    Thread.current[:current_user]
  end

  def errors_json(messages)
    { errors: [*messages] }
  end

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { error: 'Not authorized!' } }
  end
end
