# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tweets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Tweet, type: :model do
  let!(:tweet) { build(:tweet) }
  describe "正常系" do
    it "投稿できる" do
      expect(tweet).to be_valid
    end

    context "つぶやきが200文字の時" do
      it "投稿できる" do
        tweet.content = "a" * 200

        expect(tweet).to be_valid
      end
    end
  end

  describe "異常系" do
    context "つぶやき内容が空だった時" do
      it "投稿できない" do
        tweet.content = nil

        expect(tweet).to be_invalid
        expect(tweet.errors.details[:content][0][:error]).to eq :blank
      end
    end

    context "つぶやきが201文字以上の時" do
      it "投稿できない" do
        tweet.content = "a" * 201

        expect(tweet).to be_invalid
        expect(tweet.errors.details[:content][0][:error]).to eq :too_long
      end
    end
  end
end
