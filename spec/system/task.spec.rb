require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      FactoryBot.create(:testtask)
      new_task = FactoryBot.create(:testtask_second)
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'factory_title1'
        expect(page).to have_content 'factory_title2'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'factory_title2'
        expect(task_list[1]).to have_content 'factory_title1'
      end
    end
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with: 'systemspec'
        fill_in 'タスク詳細', with: 'createtest'
        click_on '登録する'
        expect(page).to have_content 'systemspec'
        expect(page).to have_content 'createtest'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          task = FactoryBot.create(:testtask)
          visit task_path(task.id)
          expect(page).to have_content 'factory_title1'
          expect(page).to have_content 'factory_content1'
       end
     end
  end
end
