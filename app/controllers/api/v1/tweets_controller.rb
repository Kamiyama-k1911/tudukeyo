class Api::V1::TweetsController < Api::V1::BaseApiController
  def index
    tweets = Tweet.eager_load(:user).all.order(created_at: "DESC")
    render json: tweets
  end

  def show
    tweet = Tweet.find(params[:id])
    render json: tweet, serializer: Api::V1::TweetDetailSerializer
  end
end
