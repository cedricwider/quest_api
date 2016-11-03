class AddClanToQuests < ActiveRecord::Migration[5.0]
  def change
    add_reference :quests, :clan, foreign_key: true
  end
end
