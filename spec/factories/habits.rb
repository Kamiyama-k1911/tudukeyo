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
FactoryBot.define do
  factory :habit do
    user { nil }
    name { "MyString" }
    continution_day { 1 }
    goal_day { 1 }
  end
end
