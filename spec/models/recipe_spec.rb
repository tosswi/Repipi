require 'rails_helper'

RSpec.describe 'Recipeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:recipe) { build(:recipe, user_id: user.id) }
    context 'nameカラム' do
      it '空欄でないこと' do
        recipe.name = ''
        expect(recipe.valid?).to eq false;
      end
      it '30文字以下であること' do
        recipe.name = Faker::Lorem.characters(number:31)
        expect(recipe.valid?).to eq false;
      end
    end
    context 'contentカラム' do
      it '空欄でないこと' do
        recipe.content = ''
        expect(recipe.valid?).to eq false;
      end
      it '2000文字以下であること' do
        recipe.content = Faker::Lorem.characters(number:2001)
        expect(recipe.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Genreモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end
    context 'Categoryモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end
    context 'BookMarkモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
    context 'RecipeReviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:recipe_reviews).macro).to eq :has_many
      end
    end
    context 'Materialモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:materials).macro).to eq :has_many
      end
    end
    context 'RecipeImageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:recipe_images).macro).to eq :has_many
      end
    end
  end
end