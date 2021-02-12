class CreateHabits < ActiveRecord::Migration[6.0]
  def change
    create_table :habits do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :continution_day
      t.integer :goal_day

      t.timestamps
    end
  end
end
