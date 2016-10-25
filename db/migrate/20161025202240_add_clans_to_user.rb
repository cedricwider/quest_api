class AddClansToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :clan, foreign_key: true
  end
end
