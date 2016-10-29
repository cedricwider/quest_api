class AddUserToAuthToken < ActiveRecord::Migration[5.0]
  def change
    add_reference :auth_tokens, :user, foreign_key: true
  end
end
