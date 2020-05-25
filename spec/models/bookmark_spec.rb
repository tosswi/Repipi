RSpec.describe 'Bookmarkモデルのテスト', type: :model do
    describe 'アソシエーションのテスト' do
        context 'Userモデルとの関係' do
            it 'N:1となっている' do
            expect(Bookmark.reflect_on_association(:user).macro).to eq :belongs_to
            end
        end
            context 'Recipeモデルとの関係' do
            it 'N:1となっている' do
            expect(Bookmark.reflect_on_association(:recipe).macro).to eq :belongs_to
            end
        end
    end
end