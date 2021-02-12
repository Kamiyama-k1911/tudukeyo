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
require 'rails_helper'

RSpec.describe TweetTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
