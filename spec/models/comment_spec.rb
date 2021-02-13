# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_tweet_id  (tweet_id)
#  index_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (tweet_id => tweets.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Comment, type: :model do
  let!(:comment) { build(:comment) }

  describe "正常系" do
    it "コメントを投稿できる" do
      expect(comment).to be_valid
    end

    context "コメントが200文字の時" do
      it "投稿できる" do
        comment.content = "a" * 200

        expect(comment).to be_valid
      end
    end
  end

  describe "異常系" do
    context "コメント内容が空だった時" do
      it "投稿できない" do
        comment.content = nil

        expect(comment).to be_invalid
        expect(comment.errors.details[:content][0][:error]).to eq :blank
      end
    end

    context "コメントが201文字以上の時" do
      it "投稿できない" do
        comment.content = "a" * 201

        expect(comment).to be_invalid
        expect(comment.errors.details[:content][0][:error]).to eq :too_long
      end
    end
  end
end
