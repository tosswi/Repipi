require 'rails_helper'

RSpec.describe 'Messageモデルのテスト', type: :model do
    let(:user) { create(:user) }
    let!(:message) { build(:message, user_id: user.id) }
    describe 'アソシエーションのテスト' do
        context 'Userモデルとの関係' do
            it 'N:1となっている' do
            expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
            end
        end
        context 'Roomモデルとの関係' do
            it 'N:1となっている' do
            expect(Message.reflect_on_association(:room).macro).to eq :belongs_to
            end
        end
        context 'Notificationモデルとの関係' do
            it '1:Nとなっている' do
            expect(Message.reflect_on_association(:notifications).macro).to eq :has_many
            end
        end
    end
    describe 'バリデーションテスト' do
        context 'contentカラム' do
            it '空欄でないこと' do
            message.content = ''
            expect(message.valid?).to eq false;
            end
            it '1000文字以下であること' do
                message.content = Faker::Lorem.characters(number:1001)
                expect(message.valid?).to eq false;
            end
        end
    end
end