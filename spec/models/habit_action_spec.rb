# == Schema Information
#
# Table name: habit_actions
#
#  id         :bigint           not null, primary key
#  is_done    :boolean
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  habit_id   :bigint           not null
#
# Indexes
#
#  index_habit_actions_on_habit_id  (habit_id)
#
# Foreign Keys
#
#  fk_rails_...  (habit_id => habits.id)
#
require "rails_helper"

RSpec.describe HabitAction, type: :model do
  let!(:habit_action) { build(:habit_action) }

  it "アクションを作成できる" do
    expect(habit_action).to be_valid
  end

  context "名前が空だった時" do
    it "アクションが作成できない" do
      habit_action.name = nil

      expect(habit_action).to be_invalid
      expect(habit_action.errors.details[:name][0][:error]).to eq :blank
    end
  end
end
