class CreateAuthTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :auth_tokens do |t|
      t.integer :lifespan
      t.string :value

      t.timestamps
    end
  end
end
