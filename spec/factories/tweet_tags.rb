# == Schema Information
#
# Table name: tweet_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag_id     :bigint           not null
#  tweet_id   :bigint           not null
#
# Indexes
#
#  index_tweet_tags_on_tag_id    (tag_id)
#  index_tweet_tags_on_tweet_id  (tweet_id)
#
# Foreign Keys
#
#  fk_rails_...  (tag_id => tags.id)
#  fk_rails_...  (tweet_id => tweets.id)
#
FactoryBot.define do
  factory :tweet_tag do
    tag { nil }
    tweet { nil }
  end
end
