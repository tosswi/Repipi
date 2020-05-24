require 'rails_helper'
  describe 'アドミンのテスト' do
    describe 'ユーザー認証のテスト' do
      before do
        visit admins_session_path
      end
      context 'トップ画面が表示する' do
        it 'ログインに成功する' do
          fill_in 'admin[email]', with: Faker::Internet.email
          fill_in 'admin[password]', with: 'encrypted_password'
          click_button 'Log in'
          visit admins_path
        end
      end
    end
    describe 'トップ画面' do
      before do
        visit admins_path
      end
      content'ヘッダーからジャンル一覧へのリンクを押下する'do
        it 'ジャンル一覧画面が表示される'do
          click_button 'ジャンル一覧'
          visit admins_genres_path
        end
      end
      content'ヘッダーからカテゴリー一覧へのリンクを押下する'do
        it 'カテゴリー一覧画面が表示される'do
          click_button 'カテゴリー一覧'
          visit admins_categories_path
        end
      end
    end

