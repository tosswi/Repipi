require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  # 名前が空欄で登録できない→名前を空欄で登録したらfalse
  # バリデーションしていない状態で失敗→設定したら成功
  # 登録できるかできないか 登録できたら失敗
  # エラーメッセージがなければ失敗

  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    subject { test_user.valid? }
    context 'nameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false;
      end
    end
    context 'phone_numberカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.phone_number = ''
        is_expected.to eq false;
      end
    end
    context 'nicknameカラム' do
      let(:test_user) { user }
      it '15文字以下であること' do
        test_user.nickname = Faker::Lorem.characters(number:16)
        is_expected.to eq false
      end
    end
    context 'emailカラム' do
      let(:test_user) { user }
      it '50文字以下であること' do
        test_user.email = Faker::Lorem.characters(number:51)
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Recipeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:recipes).macro).to eq :has_many
      end
    end
    context 'Messageモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end
    end
    context 'RecipeReviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:recipe_reviews).macro).to eq :has_many
      end
    end
    context 'BookMarkモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end
    context 'Entryモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:entries).macro).to eq :has_many
      end
    end
  end
end
# アソシエーションのテスト