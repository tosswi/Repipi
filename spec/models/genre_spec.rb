RSpec.describe 'Genreモデルのテスト', type: :model do
    let!(:genre) { build(:genre) }
    describe 'アソシエーションのテスト' do
        context 'Recipeモデルとの関係' do
            it '1:Nとなっている' do
            expect(Genre.reflect_on_association(:recipes).macro).to eq :has_many
            end
        end
    end
    describe 'バリデーションテスト' do
        context 'nameカラム' do
            it '空欄でないこと' do
            genre.name = ''
            expect(genre.valid?).to eq false;
            end
            it '15文字以下であること' do
                genre.name = Faker::Lorem.characters(number:16)
                expect(genre.valid?).to eq false;
            end
        end
    end
end
