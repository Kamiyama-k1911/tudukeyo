RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }

    let!(:params) { attributes_for(:user) }
    it "新規登録できる" do
      expect { subject }.to change { User.count }.by(1)

      res = JSON.parse(response.body)

      expect(res["data"]["email"]).to eq User.last.email
      expect(res["data"]["name"]).to eq User.last.name
      expect(response).to have_http_status :ok
    end

    it "必要なheader情報が取得できる" do
      subject

      res = response.headers
      expect(res["access-token"]).to be_present
      expect(res["client"]).to be_present
      expect(res["expiry"]).to be_present
      expect(res["uid"]).to be_present
      expect(res["token-type"]).to be_present
    end

    context "paramsにnameが存在しなかった時" do
      let(:params) { attributes_for(:user, name: nil) }
      it "新規登録できない" do
        expect { subject }.to change { User.count }.by(0)

        res = JSON.parse(response.body)

        expect(res["errors"]["name"][0]).to eq "can't be blank"
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context "paramsにemailが存在しなかった時" do
      let(:params) { attributes_for(:user, email: nil) }
      it "新規登録できない" do
        expect { subject }.to change { User.count }.by(0)

        res = JSON.parse(response.body)

        expect(res["errors"]["email"][0]).to eq "can't be blank"
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context "paramsにpasswordが存在しなかった時" do
      let(:params) { attributes_for(:user, password: nil) }
      it "新規登録できない" do
        expect { subject }.to change { User.count }.by(0)

        res = JSON.parse(response.body)

        expect(res["errors"]["password"][0]).to eq "can't be blank"
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
