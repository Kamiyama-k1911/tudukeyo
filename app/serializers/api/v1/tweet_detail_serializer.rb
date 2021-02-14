class Api::V1::TweetDetailSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at

  belongs_to :user, serializer: Api::V1::UserTweetDetailSerializer
end
