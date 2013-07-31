class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :owner_id
      t.string :twitter_name
      t.string :oauth_token
      t.string :oauth_token_secret
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end
