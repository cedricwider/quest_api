class QueriesController < ApplicationController

  def create
    context = { current_user: @current_user }
    render json: UserSchema.execute(query, variables: variables, context: context)
  end

  private

  def query
    params[:query]
  end

  def variables
    params[:variables] || {}
  end

end
