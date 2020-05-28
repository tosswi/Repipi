require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: Faker::Internet.username(specifier: 15)
        fill_in 'user[nickname]',with: Faker::Lorem.characters(number:10) 
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[phone_number]', with: Faker::Lorem.characters(number:10)
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button 'Sign up'

        expect(page).to have_content 'ようこそ！'
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[nickname]',with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[phone_number]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button 'Sign up'

        expect(page).to have_content 'ユーザー登録できませんでした'
      end
    end
  end
  describe 'ユーザーログイン' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user) { user }
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_button 'Log in'

        expect(page).to have_content 'ログインできました'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end

describe 'ユーザーのテスト' do
  let(:user) { create(:user) }
  let!(:test_user2) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe '編集のテスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
    end
    context '他人の編集画面への遷移' do
      it '遷移できない' do
        visit edit_user_path(test_user2)
        expect(current_path).to eq('/')
      end
    end

    context '表示の確認' do
      before do
        visit edit_user_path(user)
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[nickname]', with: user.nickname
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[image]'
      end
      it '編集に成功する' do
        click_button '更新する'
        expect(page).to have_content 'カテゴリーから'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
      it '編集に失敗する' do
        fill_in 'user[nickname]', with: ''
        click_button '更新する'
        expect(page).to have_content 'カテゴリーから'
				#もう少し詳細にエラー文出したい
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end
  end

  describe '一覧画面のテスト' do
    before do
      visit users_path
    end
    context '表示の確認' do
      it 'Usersと表示される' do
        expect(page).to have_content('友達検索')
      end
      it '自分と他の人の画像が表示される' do
        expect(all('img').size).to eq(3)
      end
      it '自分と他の人の名前が表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content test_user2.name
      end
    end
  end
end

describe 'Adminのテスト' do
  let(:admin) { create(:admin) }
  let!(:test_admin2) { create(:admin) }
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'
  end
end
describe 'topページのテスト' do
  let(:admin) { create(:admin) }
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'
    visit admins_path
  end
  context '表示の確認' do
    it 'adminsと表示される' do
      expect(page).to have_content('本日の登録者数は')
    end
  end
  context 'ヘッダーから注文履歴一覧へのリンクを押下する' do
    #subject { admins_path }
    it 'カテゴリー一覧に遷移する'do

      #click_link ' カテゴリー登録'
      visit admins_categories_path
      expect(page).to have_current_path '/admins/categories'
      #is_expected.to eq('admins/categories')
    end
    # it 'About画面に遷移する' do
    #   about_link = find_all('a')[1].native.inner_text
    #   #about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
    #   click_link about_link
    #   is_expected.to eq('/home/about')
    # end
    # it '新規登録画面に遷移する' do
    #   signup_link = find_all('a')[2].native.inner_text
    #   #signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
    #   click_link signup_link
    #   is_expected.to eq(new_user_registration_path)
    # end
    # it 'ログイン画面に遷移する' do
    #   login_link = find_all('a')[3].native.inner_text
    #   login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
    #   click_link login_link
    #   is_expected.to eq(new_user_session_path)
    # end
  end
end

