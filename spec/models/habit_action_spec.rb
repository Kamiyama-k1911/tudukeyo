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
require 'rails_helper'

RSpec.describe HabitAction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
