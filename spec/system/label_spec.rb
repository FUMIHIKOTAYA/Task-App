require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:factory_user) { create(:user) }
  let!(:factory_administrator) { create(:administrator) }
  let!(:label) { create(:testlabel) }
  let!(:third_label) { create(:testlabel_third, user: factory_administrator) }
  let!(:fourth_label) { create(:testlabel_fourth, user: factory_user) }
  before do
    visit new_session_path
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'password'
    click_button 'ログイン'
  end

  describe '新規ラベル作成機能' do
    context 'ラベルを新規作成した場合' do
      it '作成したラベルが表示されること' do
        visit new_label_path
        fill_in 'ラベル', with: 'label_sample'
        click_on '登録する'
        expect(page).to have_content 'label_sample'
      end
      before do
        visit new_task_path
      end
      it '自分が作成したラベルをタスクに使用できる' do
        fill_in 'タスク名', with: 'title_sample'
        fill_in 'タスク詳細', with: 'content_sample'
        select_date("2020,10,31", from: "終了期限")
        select_time("17", "00", from: "終了期限")
        select '着手中', from: 'ステータス'
        select '高', from: '優先度'
        within '#label-test' do
          check "factory_label3"
        end
        click_on '登録する'
        click_on '登録する'
        expect(page).to have_content 'factory_label3'
      end
      it '他の人が作成したラベルは表示されない' do
        expect(page).not_to have_content 'factory_label4'
      end
    end
  end
end
