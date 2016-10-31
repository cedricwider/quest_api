class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate
  after_action :set_auth_header

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token_value, _|
      token = AuthToken.find_by(value: token_value)
      if token.present? && token.active?
        token.touch
        @current_user = token.user
      else
        head :unauthorized
        return false
      end
    end
  end

  def set_auth_header
    if @current_user.present? && @current_user.auth_token.present?
      response.headers['HTTP_AUTHORIZATION'] = @current_user.auth_token.value
    end
  end
end
