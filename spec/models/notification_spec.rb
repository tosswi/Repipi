require 'rails_helper'

RSpec.describe 'Notificationモデルのテスト', type: :model do
    describe 'アソシエーションのテスト' do
        context 'Recipeモデルとの関係' do
            it 'N:1となっている' do
            expect(Notification.reflect_on_association(:recipe).macro).to eq :belongs_to
            end
        end
        context 'RecipeReviewモデルとの関係' do
            it 'N:1となっている' do
            expect(Notification.reflect_on_association(:recipe_review).macro).to eq :belongs_to
            end
        end
        context 'Messageモデルとの関係' do
            it 'N:1となっている' do
            expect(Notification.reflect_on_association(:message).macro).to eq :belongs_to
            end
        end
    end
end