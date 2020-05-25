require 'rails_helper'

RSpec.describe 'Adminモデルのテスト', type: :model do
  # 名前が空欄で登録できない→名前を空欄で登録したらfalse
  # バリデーションしていない状態で失敗→設定したら成功
  # 登録できるかできないか 登録できたら失敗
  # エラーメッセージがなければ失敗
  let(:admin) { build(:admin) }
  subject { admin.valid? }

    describe 'バリデーションのテスト' do
        let(:test_admin) { admin }
        context 'emailカラム' do
            it '空欄でないこと' do
                test_admin.email = '' 
                is_expected.to eq false;
            end
        end
        context 'emailカラム' do
            let(:test_admin) { admin }
            it '50文字以下であること' do
                test_admin.email = Faker::Lorem.characters(number:51)
                is_expected.to eq false
            end
        end
    end
end