class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token_value, _|
      token = AuthToken.find_by(value: token_value)
      @current_user = token.user
    end
  end
end
