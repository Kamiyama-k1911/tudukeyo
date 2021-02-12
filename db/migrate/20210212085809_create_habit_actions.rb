class CreateHabitActions < ActiveRecord::Migration[6.0]
  def change
    create_table :habit_actions do |t|
      t.references :habit, null: false, foreign_key: true
      t.string :name
      t.boolean :is_done

      t.timestamps
    end
  end
end
