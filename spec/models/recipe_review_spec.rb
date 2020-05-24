require 'rails_helper'

RSpec.describe 'RecipeReviewモデルのテスト', type: :model do
    let(:user) { create(:user) }
    let!(:recipe_review) { build(:recipe_review, user_id: user.id) }
    describe 'アソシエーションのテスト' do
        context 'Userモデルとの関係' do
            it 'N:1となっている' do
            expect(RecipeReview.reflect_on_association(:user).macro).to eq :belongs_to
            end
        end
        context 'Recipeモデルとの関係' do
            it 'N:1となっている' do
            expect(RecipeReview.reflect_on_association(:recipe).macro).to eq :belongs_to
            end
        end
    end
    describe 'バリデーションテスト' do
        context 'recipe_commentカラム' do
            it '空欄でないこと' do
            recipe_review.recipe_comment = ''
            expect(recipe_review.valid?).to eq false;
            end
            it '1000文字以下であること' do
                recipe_review.recipe_comment = Faker::Lorem.characters(number:1001)
                expect(recipe_review.valid?).to eq false;
            end
        end
    end
end