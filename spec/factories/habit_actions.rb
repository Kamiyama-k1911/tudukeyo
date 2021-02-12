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
FactoryBot.define do
  factory :habit_action do
    habit { nil }
    name { "MyString" }
    is_done { false }
  end
end
