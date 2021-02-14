require 'rails_helper'

RSpec.describe "Api::V1::Tweets", type: :request do
  describe "GET api/v1/tweets" do
    subject { get(api_v1_tweets_path) }

    let!(:tweet_1) { create(:tweet,created_at: 2.days.ago) }
    let!(:tweet_2) { create(:tweet,created_at: 1.days.ago) }
    let!(:tweet_3) { create(:tweet) }
    it "ツイートの一覧を取得できる" do
      subject

      res = JSON.parse(response.body)
      # idだけ抜き出した配列
      res_id_array = res.map { |h| h["id"] }

      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "content", "created_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "profile", "avatar"]
      expect(res_id_array).to eq [tweet_3.id,tweet_2.id,tweet_1.id]
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
      let!(:tweet_id) { 1000000 }
      it "ツイートの詳細を取得できない" do
        expect{ subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

end
