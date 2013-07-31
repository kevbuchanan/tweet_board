class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.string :twitter_name
      t.timestamps
    end
  end
end
