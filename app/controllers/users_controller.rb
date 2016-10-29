require 'digest/sha2'
class UsersController < ApplicationController

  skip_before_action :authenticate, only: :create

  # GET /users
  def index
    head :forbidden
  end

  # GET /users/1
  def show
    render json: user
  end

  # POST /users
  def create
    @current_user = User.new(user_params)

    if @current_user.save
      render json: @current_user, status: :created, location: @current_user
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if user.update(user_params)
      render json: user
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

  def encrypt(cleartext)
    Digest::SHA2.hexdigest cleartext
  end
end
