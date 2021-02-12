class CreateRelationShips < ActiveRecord::Migration[6.0]
  def change
    create_table :relation_ships do |t|
      t.integer :follower_id, null: false, foreign_key: true
      t.integer :followed_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
