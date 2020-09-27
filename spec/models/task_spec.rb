require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = FactoryBot.build(:testtask, title: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = FactoryBot.build(:testtask, content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = FactoryBot.build(:testtask, title: '成功テスト', content: '成功テスト')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:testtask) }
    let!(:second_task) { FactoryBot.create(:testtask_second, title: 'sample') }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_title('factory')).to include(task)
        expect(Task.search_title('factory')).not_to include(second_task)
        expect(Task.search_title('factory').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status(2)).to include(task)
        expect(Task.search_status(2)).not_to include(second_task)
        expect(Task.search_status(2).count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('sample').search_status(0)).to include(second_task)
        expect(Task.search_title('sample').search_status(0)).not_to include(task)
        expect(Task.search_title('sample').search_status(0).count).to eq 1
      end
    end
  end
end
