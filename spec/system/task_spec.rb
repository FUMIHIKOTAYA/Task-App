require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:factory_user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:testtask, user: factory_user) }
  let!(:second_task) { FactoryBot.create(:testtask_second, user: factory_user) }
  let!(:third_task) { FactoryBot.create(:testtask_third, user: factory_user) }
  before do
    visit new_session_path
    fill_in 'Email', with: 'user@factory.com'
    fill_in 'Password', with: 'bbbbbb'
    click_button 'ログイン'
    visit tasks_path
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'factory_title1'
        expect(page).to have_content 'factory_title2'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'factory_title3'
        expect(task_list[1]).to have_content 'factory_title2'
        expect(task_list[2]).to have_content 'factory_title1'
      end
    end
    context '終了期限でソートするというリンクを押した場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        click_link '終了期限でソートする'
        expect(page).to have_content 'タスク一覧'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'factory_title2'
        expect(task_list[1]).to have_content 'factory_title3'
        expect(task_list[2]).to have_content 'factory_title1'
      end
    end
    context '優先順位でソートするというリンクを押した場合' do
      it '優先順位の高い順に並び替えられたタスク一覧が表示される' do
        click_link '優先順位でソートする'
        expect(page).to have_content 'タスク一覧'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'factory_title3'
        expect(task_list[1]).to have_content 'factory_title1'
        expect(task_list[2]).to have_content 'factory_title2'
      end
    end
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'title_sample'
        fill_in 'タスク詳細', with: 'content_sample'
        select_date("2020,9,29", from: "終了期限")
        select_time("17", "00", from: "終了期限")
        select '着手中', from: 'ステータス'
        select '高', from: '優先度'
        click_on '登録する'
        expect(page).to have_content 'title_sample'
        expect(page).to have_content 'content_sample'
        expect(page).to have_content '2020/09/29 17:00'
        expect(page).to have_content '着手中'
        expect(page).to have_content '高'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          visit task_path(task.id)
          expect(page).to have_content 'factory_title1'
          expect(page).to have_content 'factory_content1'
       end
     end
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'タスク名', with: '1'
        click_on 'searchbutton'
        expect(page).to have_content 'factory_title1'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '未着手', from: 'status'
        click_on 'searchbutton'
        expect(page).to have_content 'factory_title2'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'タスク名', with: 'factory'
        select '着手中', from: 'status'
        click_on 'searchbutton'
        expect(page).to have_content 'factory_title3'
      end
    end
  end
end
