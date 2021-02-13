require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { build(:user) }

  describe "正常系" do
    it "ユーザー登録できる" do
      expect(user).to be_valid
    end

    context "名前が25文字の時" do
      it "ユーザー登録できる" do
        user.name = "a" * 25

        expect(user).to be_valid
      end
    end

    context "パスワードが8文字の時" do
      it "ユーザー登録できる" do
        user.password = "a" * 8

        expect(user).to be_valid
      end
    end

    context "パスワードが32文字の時" do
      it "ユーザー登録できる" do
        user.password = "a" * 32

        expect(user).to be_valid
      end
    end


    context "プロフィールが300文字の時" do
      it "ユーザー登録できる" do
        user.profile = "a" * 300

        expect(user).to be_valid
      end
    end
  end

  describe "異常系" do
    context "名前が空の時" do
      it "ユーザー登録できない" do
        user.name = nil

        expect(user).to be_invalid
        expect(user.errors.details[:name][0][:error]).to eq :blank
      end
    end

    context "名前が26文字以上の時" do
      it "ユーザー登録できない" do
        user.name = "a" * 26

        expect(user).to be_invalid
        expect(user.errors.details[:name][0][:error]).to eq :too_long
      end
    end

    context "メールアドレスが空の時" do
      it "ユーザー登録できない" do
        user.email = nil

        expect(user).to be_invalid
        expect(user.errors.details[:email][0][:error]).to eq :blank
      end
    end

    context "既に同じメールアドレスが登録されている時" do
      before { create(:user,email: "aaa@example.com") }

      it "ユーザー登録できない" do
        user.email = "aaa@example.com"

        expect(user).to be_invalid
        expect(user.errors.details[:email][0][:error]).to eq :taken
      end
    end

    context "メールアドレスが@から始まる時" do
      it "ユーザー登録できない" do
        user.email = "@example.com"

        expect(user).to be_invalid
        expect(user.errors.details[:email][0][:error]).to eq "is not an email"
      end
    end

    context "メールアドレスに.が含まれない時" do
      it "ユーザー登録できない" do
        user.email = "aaa@examplecom"

        expect(user).to be_invalid
        expect(user.errors.details[:email][0][:error]).to eq "is not an email"
      end
    end

    context "メールアドレスの.の後に記号が含まれている時" do
      it "ユーザー登録できない" do
        user.email = "aaa@example.++com"

        expect(user).to be_invalid
        expect(user.errors.details[:email][0][:error]).to eq "is not an email"
      end
    end

    context "パスワードが空の時" do
      it "ユーザー登録できない" do
        user.password = nil

        expect(user).to be_invalid
        expect(user.errors.details[:password][0][:error]).to eq :blank
      end
    end

    context "パスワードが7文字の時" do
      it "ユーザー登録できない" do
        user.password = "a" * 7

        expect(user).to be_invalid
        expect(user.errors.details[:password][0][:error]).to eq :too_short
      end
    end

    context "パスワードが33文字の時" do
      it "ユーザー登録できない" do
        user.password = "a" * 33

        expect(user).to be_invalid
        expect(user.errors.details[:password][0][:error]).to eq :too_long
      end
    end

    context "プロフィールが301文字の時" do
      it "ユーザー登録できない" do
        user.profile = "a" * 301

        expect(user).to be_invalid
        expect(user.errors.details[:profile][0][:error]).to eq :too_long
      end
    end

    context "プロフィールが300文字以上の時" do
      it "ユーザー登録できない" do
        user.profile = "a" * 301

        expect(user).to be_invalid
        expect(user.errors.details[:profile][0][:error]).to eq :too_long
      end
    end
  end
end