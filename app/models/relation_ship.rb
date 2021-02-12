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
class RelationShip < ApplicationRecord
  belongs_to :follower,class_name: "User"
  belongs_to :followed,class_name: "User"
end
