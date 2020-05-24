require 'rails_helper'
RSpec.describe 'RecipeImageモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let!(:recipe) { build(:recipe, user_id: user.id) }
  let!(:recipe_image) { build(:recipe_image, recipe_id: recipe.id) }
    describe 'アソシエーションのテスト' do
    context 'Recipeモデルとの関係' do
      it 'N:1となっている' do
      expect(RecipeImage.reflect_on_association(:recipe).macro).to eq :belongs_to
      end
    end
  end
  describe 'バリデーションのテスト' do
    context 'recipe_imageカラム' do
      it '空欄でないこと' do
        recipe_image.recipe_image = ''
        expect(recipe_image.valid?).to eq false;
      end
    end
  end
end