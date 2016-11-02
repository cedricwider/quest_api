class UsersController < ApplicationController

  include Encryptable

  skip_before_action :authenticate, only: :create

  # GET /users
  def index
    head :forbidden
  end

  # GET /users/<email>
  def show
    render json: user_response
  end

  # POST /users
  def create
    @current_user = User.new(user_params)

    if @current_user.save
      render json: user_response(from_user: @current_user), status: :created, location: @current_user
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    return head :not_found unless user.present?
    if user.update(user_params)
      render json: user_response
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    user.destroy
  end

  private

  def user
    @user ||= User.find_by(email: params[:id])
  end

  def user_params
    user_params = JSON.parse(request.body.read)
                      .symbolize_keys.slice(:first_name, :last_name, :hero_name, :email, :password)
    user_params.update(user_params) { |k, v| k == :password ? encrypt(v) : v }
  end

  def user_response(from_user: user)
    {
      id: from_user.id,
      first_name: from_user.first_name,
      last_name: from_user.last_name,
      hero_name: from_user.hero_name,
      email: from_user.email,
      clan_id: from_user.clan_id
    }
  end
end
