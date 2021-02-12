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
require "rails_helper"

RSpec.describe RelationShip, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
