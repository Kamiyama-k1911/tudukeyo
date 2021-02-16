class Api::V1::TweetsController < Api::V1::BaseApiController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    tweets = Tweet.eager_load(:user).all.order(created_at: "DESC")
    render json: tweets
  end

  def show
    tweet = Tweet.find(params[:id])
    render json: tweet, serializer: Api::V1::TweetDetailSerializer
  end

  def create
    tweet = current_user.tweets.create!(tweet_param)
    render json: tweet
  end

  def destroy
    tweet = current_user.tweets.find(params[:id])
    tweet.destroy!
    render json: tweet
  end

  private

    def tweet_param
      params.require(:tweet).permit(:content)
    end
end
