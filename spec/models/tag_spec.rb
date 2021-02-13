# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :bigint           not null
#
# Indexes
#
#  index_tags_on_tweet_id  (tweet_id)
#
# Foreign Keys
#
#  fk_rails_...  (tweet_id => tweets.id)
#
require "rails_helper"

RSpec.describe Tag, type: :model do
  let!(:tag) { build(:tag) }

  it "タグを作成できる" do
    expect(tag).to be_valid
  end

  context "名前が空だった時" do
    it "タグを作成できない" do
      tag.name = nil

      expect(tag).to be_invalid
      expect(tag.errors.details[:name][0][:error]).to eq :blank
    end
  end
end
