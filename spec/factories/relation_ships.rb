# == Schema Information
#
# Table name: relation_ships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
FactoryBot.define do
  factory :relation_ship do
    follower_id { 1 }
    followed_id { 1 }
  end
end
