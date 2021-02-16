RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }

    let!(:params) { { email: user.email, password: user.password } }
    let!(:user) { create(:user) }
    it "ログインできる" do
      subject

      res = response.headers
      expect(res["access-token"]).to be_present
      expect(res["client"]).to be_present
      expect(res["expiry"]).to be_present
      expect(res["uid"]).to be_present
      expect(res["token-type"]).to be_present
      expect(response).to have_http_status :ok
    end

    context "paramsにemailが存在しなかった時" do
      let!(:params) { { password: user.password } }
      it "ログインできない" do
        subject

        res = JSON.parse(response.body)

        expect(res["errors"][0]).to eq "Invalid login credentials. Please try again."
        expect(response).to have_http_status :unauthorized
      end
    end

    context "paramsにpasswordが存在しなかった時" do
      let!(:params) { { email: user.email } }
      it "ログインできない" do
        subject

        res = JSON.parse(response.body)

        expect(res["errors"][0]).to eq "Invalid login credentials. Please try again."
        expect(response).to have_http_status :unauthorized
      end
    end
  end

  describe "DELETE /api/v1/auth/sign_out" do
    subject { delete(destroy_api_v1_user_session_path, headers: headers) }

    let!(:params) { { email: user.email, password: user.password } }
    let!(:user) { create(:user) }
    let!(:headers) { user.create_new_auth_token }
    context "ログイン状態にある時" do
      it "ログアウトできる" do
        expect{ subject }.to change { user.reload.tokens }.from(be_present).to(be_blank)

        expect(response).to have_http_status :ok
      end
    end

    context "header情報を渡せていない時" do
      subject { delete(destroy_api_v1_user_session_path) }

      it "ログアウトできない" do
        subject

        res = JSON.parse(response.body)
        expect(res["errors"][0]).to eq "User was not found or was not logged in."
        expect(response).to have_http_status :not_found
      end
    end
  end
end