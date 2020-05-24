RSpec.describe 'Messageモデルのテスト', type: :model do
    describe 'アソシエーションのテスト' do
        context 'Recipeモデルとの関係' do
            it 'N:1となっている' do
            expect(Material.reflect_on_association(:recipe).macro).to eq :belongs_to
            end
        end
    end
end
