RSpec.describe 'Categoryモデルのテスト', type: :model do
    let!(:category) { build(:category) }
    describe 'アソシエーションのテスト' do
        context 'Recipeモデルとの関係' do
            it '1:Nとなっている' do
            expect(Category.reflect_on_association(:recipes).macro).to eq :has_many
            end
        end
    end
    describe 'バリデーションテスト' do
        context 'nameカラム' do
            it '空欄でないこと' do
            category.name = ''
            expect(category.valid?).to eq false;
            end
            it '15文字以下であること' do
                category.name = Faker::Lorem.characters(number:16)
                expect(category.valid?).to eq false;
            end
        end
    end
end
