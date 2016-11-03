class QuestsController < ApplicationController

  # GET /quests
  def index
    @quests = Quest.where(clan: @current_user.clan).to_a

    render json: @quests
  end

  # GET /quests/1
  def show
    render json: quest
  end

  # POST /quests
  def create
    @quest = Quest.new(quest_json)
    @quest.clan = @current_user.clan
    if @quest.save
      render json: @quest, status: :created, location: @quest
    else
      render json: @quest.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quests/1
  def update
    if quest.update(quest_json)
      render json: quest
    else
      render json: quest.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quests/1
  def destroy
    quest.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def quest
      @quest ||= Quest.find(params[:id])
    end

    def quest_json
      JSON.parse(request.body.read)
        .symbolize_keys.slice(:name, :description, :user_id)
    end
end
