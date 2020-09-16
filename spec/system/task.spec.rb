require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:testtask)
        visit tasks_path
        expect(page).to have_content 'タスク１'
        expect(page).to have_content 'タスク１内容'
      end
    end
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Title', with: 'systemspec'
        fill_in 'Content', with: 'createtest'
        click_on 'Create Task'
        expect(page).to have_content 'systemspec'
        expect(page).to have_content 'createtest'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          task = FactoryBot.create(:testtask, content: 'タスク１追加内容')
          visit task_path(task.id)
          expect(page).to have_content 'タスク１'
          expect(page).to have_content 'タスク１追加内容'
       end
     end
  end
end
