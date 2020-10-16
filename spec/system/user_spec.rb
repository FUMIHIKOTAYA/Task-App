require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:administrator) { FactoryBot.create(:administrator) }
  let!(:user) { FactoryBot.create(:user) }

  describe 'ユーザー登録機能' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示されること' do
        visit new_user_path
        fill_in 'ユーザー名', with: 'name_sample'
        fill_in 'メールアドレス', with: 'email@sample.com'
        fill_in 'パスワード', with: 'sample'
        fill_in 'パスワード（確認）', with: 'sample'
        click_on '登録する'
        expect(page).to have_content 'name_sample'
        expect(page).to have_content 'email@sample.com'
      end
    end
    context 'ログインせずにタスク一覧画面に移動しようとした場合' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
        expect(page).to have_content 'ログインして始められます。'
      end
    end
  end

  describe 'セッション機能' do
    context 'ログインした場合' do
      it '登録済みのユーザー名が表示されること' do
        visit new_session_path
        fill_in 'Email', with: 'admin@example.com'
        fill_in 'Password', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'factory_name1'
      end
    end
    before do
      visit new_session_path
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'ログイン'
    end
    context 'ユーザーがログインしている場合' do
      it '自分の詳細画面(マイページ)にアクセスできること' do
        visit user_path(user)
        expect(page).to have_selector 'h1', text: 'factory_name2さんのページ'
      end
    end
    context '一般ユーザーがログインしている場合' do
      it '他人の詳細画面にアクセスするとタスク一覧画面に遷移すること' do
        visit user_path(administrator)
        expect(page).to have_content '実行権限がありません。'
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'ログアウトができること' do
        click_link "ログアウト"
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面機能' do
    context '一般ユーザーがログインしている場合' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'password'
        click_button 'ログイン'
      end
      it '管理画面にアクセスできないこと' do
        visit admin_users_path
        expect(page).to have_content '管理者権限のあるユーザーアカウントでログインする必要があります。'
      end
    end
    context '管理ユーザーがログインしている場合' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'admin@example.com'
        fill_in 'Password', with: 'password'
        click_button 'ログイン'
        visit admin_users_path
      end
      it '管理画面にアクセスできること' do
        expect(page).to have_selector 'h1', text: 'ユーザー一覧'
      end
      it 'ユーザーの新規登録ができること' do
        visit new_admin_user_path
        fill_in 'ユーザー名', with: 'name_sample2'
        fill_in 'メールアドレス', with: 'email@sample2.com'
        fill_in 'パスワード', with: 'sample2'
        fill_in 'パスワード（確認）', with: 'sample2'
        uncheck '管理者権限'
        click_on '登録する'
        expect(page).to have_content 'name_sample2'
        expect(page).to have_content 'email@sample2.com'
      end
      it 'ユーザーの詳細画面にアクセスできること' do
        all('#show-link')[0].click_link '詳細'
        expect(page).to have_content 'ユーザーの詳細'
      end
      it 'ユーザーの編集画面からユーザを編集できること' do
        all('#edit-link')[0].click_link '編集'
        fill_in 'ユーザー名', with: 'name_sample3'
        fill_in 'メールアドレス', with: 'email@sample3.com'
        fill_in 'パスワード', with: 'sample3'
        fill_in 'パスワード（確認）', with: 'sample3'
        check '管理者権限'
        click_on '登録する'
        expect(page).to have_content 'name_sample3'
      end
      it 'ユーザーの削除をできること' do
        all('#delete-link')[0].click_link '削除'
        expect(page.accept_confirm).to eq '削除します。よろしいですか。'
        expect(page).to have_content 'ユーザーアカウントを削除しました。'
      end
    end
  end
end
