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
FactoryBot.define do
  factory :comment do
    user { nil }
    tweet { nil }
    content { "MyString" }
  end
end
