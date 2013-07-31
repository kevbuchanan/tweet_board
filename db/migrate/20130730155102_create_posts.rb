class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :board_id
      t.integer :contributor_id
      t.string :tweet_id
      t.text :text
      t.string :photo
      t.string :video
      t.time :start_date
      t.time :end_date
      t.timestamps
    end
  end
end
