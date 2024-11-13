# frozen_string_literal: true

# Used to authenticate the user
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user

  private

  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    begin
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      @current_user = User.find(decoded['user_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
