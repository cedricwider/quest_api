class LoginsController< ApplicationController
  include Encryptable

  skip_before_action :authenticate, only: :create

  def create
    if valid_login?
      @current_user = user
      head :ok
    else
      render json: { error: 'invalid user credentials' }, status: :unauthorized
    end
  end

  private

  def valid_login?
    user.present? && user.password == login_params[:password]
  end

  def login_params
    login_params = JSON.parse(request.body.read)
                     .symbolize_keys.slice(:email, :password)
    login_params.update(login_params) { |k, v| k == :password ? encrypt(v) : v }
  end

  def user
    @user ||= User.find_by(email: login_params[:email])
  end
end
