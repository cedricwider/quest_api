class AddPasswordToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :password, :string, nullable: false
  end
end
