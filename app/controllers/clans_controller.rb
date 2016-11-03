class ClansController < ApplicationController

  # GET /clans
  def index
    @clans = Clan.all

    render json: @clans
  end

  # GET /clans/1
  def show
    render json: clan
  end

  # POST /clans
  def create
    @clan = Clan.new(request_clan)

    if @clan.save
      render json: @clan, status: :created, location: @clan
    else
      render json: @clan.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clans/1
  def update
    if clan.update(request_clan)
      render json: clan
    else
      render json: clan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clans/1
  def destroy
    clan.destroy
  end

  private

    def request_clan
      JSON.parse(request.body.read).symbolize_keys.slice(:name)
    end

    def clan
      @clan = Clan.find(params[:id])
    end
end
