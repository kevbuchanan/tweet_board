class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.string :twitter_name
      t.string :twitter_id
      t.timestamps
    end
  end
end
