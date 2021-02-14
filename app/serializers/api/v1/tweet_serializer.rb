class Api::V1::TweetSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at

  belongs_to :user
end
