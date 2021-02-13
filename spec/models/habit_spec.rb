# == Schema Information
#
# Table name: habits
#
#  id              :bigint           not null, primary key
#  continution_day :integer
#  goal_day        :integer
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_habits_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Habit, type: :model do
  let!(:habit) { build(:habit) }

  it "習慣を作成できる" do
    expect(habit).to be_valid
  end

  context "名前が空だった時" do
    it "習慣が作成できない" do
      habit.name = nil

      expect(habit).to be_invalid
      expect(habit.errors.details[:name][0][:error]).to eq :blank
    end
  end
end
