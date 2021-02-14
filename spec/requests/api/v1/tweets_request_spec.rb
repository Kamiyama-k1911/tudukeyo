require "rails_helper"

RSpec.describe "Api::V1::Tweets", type: :request do
  describe "GET api/v1/tweets" do
    subject { get(api_v1_tweets_path) }

    let!(:tweet1) { create(:tweet, created_at: 2.days.ago) }
    let!(:tweet2) { create(:tweet, created_at: 1.days.ago) }
    let!(:tweet3) { create(:tweet) }
    it "ツイートの一覧を取得できる" do
      subject

      res = JSON.parse(response.body)
      # idだけ抜き出した配列
      res_id_array = res.map {|h| h["id"] }
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "content", "created_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "profile", "avatar"]
      expect(res_id_array).to eq [tweet3.id, tweet2.id, tweet1.id]
      expect(response).to have_http_status :ok
    end
  end

  describe "GET api/v1/tweets/:id" do
    subject { get(api_v1_tweet_path(tweet_id)) }

    let!(:tweet) { create(:tweet) }
    let!(:tweet_id) { tweet.id }
    it "ツイートの詳細を取得できる" do
      subject

      res = JSON.parse(response.body)
      expect(res["id"]).to eq tweet_id
      expect(res["content"]).to eq tweet.content
      expect(res["created_at"]).to be_present
      expect(res["user"]["id"]).to eq tweet.user.id
      expect(res.keys).to eq ["id", "content", "created_at", "user"]
      expect(res["user"].keys).to eq ["id", "name", "avatar"]
      expect(response).to have_http_status :ok
    end

    context "存在しないidを指定した時" do
      let(:tweet_id) { 1_000_000 }
      it "ツイートの詳細を取得できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST api/v1/tweets" do
    subject { post(api_v1_tweets_path(params: params)) }

    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    let!(:params) { { tweet: attributes_for(:tweet) } }
    let!(:current_user) { create(:user) }
    it "ツイートできる" do
      expect { subject }.to change { Tweet.where(user_id: current_user.id).count }.by(1)

      res = JSON.parse(response.body)

      expect(res["content"]).to eq params[:tweet][:content]
      expect(response).to have_http_status :ok
    end

    context "パラメーターの渡し方が間違っていた時" do
      let(:params) { attributes_for(:tweet) }

      it "ツイートを作成できない" do
        expect { subject }.to raise_error ActionController::ParameterMissing
      end
    end
  end

  describe "DELETE api/v1/tweets/:id" do
    subject { delete(api_v1_tweet_path(tweet_id)) }

    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    let!(:tweet) { create(:tweet, user_id: current_user_id) }
    let!(:tweet_id) { tweet.id }
    let!(:current_user) { create(:user) }
    let!(:current_user_id) { current_user.id }

    it "ツイートを削除できる" do
      expect { subject }.to change { Tweet.where(user_id: current_user_id).count }.by(-1)

      res = JSON.parse(response.body)
      expect(res["id"]).to eq tweet_id
      expect(res["content"]).to eq tweet.content
      expect(res["created_at"]).to be_present
      expect(response).to have_http_status :ok
    end

    context "自分以外のユーザーのツイートを削除しようとした時" do
      let!(:other_user) { create(:user) }
      let(:tweet) { create(:tweet, user: other_user) }

      it "ツイートを削除できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
