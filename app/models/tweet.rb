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
class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :habits, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :tweet_tags, dependent: :destroy

  validates :content, presence: true, length: { maximum: 200 }
end
