class CreateContributorsBoards < ActiveRecord::Migration
  def change
    create_table :contributors_boards do |t|
      t.integer :contributor_id
      t.integer :board_id
      t.timestamps
    end
  end
end
