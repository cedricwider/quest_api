class AddUserToQuest < ActiveRecord::Migration[5.0]
  def change
    add_reference :quests, :user, foreign_key: true
  end
end
