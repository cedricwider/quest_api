class CreateQuests < ActiveRecord::Migration[5.0]
  def change
    create_table :quests do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
