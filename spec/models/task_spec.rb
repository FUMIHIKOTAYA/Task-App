require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  let!(:factory_administrator) { create(:administrator) }
  let!(:label) { create(:testlabel) }
  let!(:second_label) { create(:testlabel_second) }
  let!(:task) { create(:testtask, user: factory_administrator, label_ids: [label.id]) }
  let!(:second_task) { create(:testtask_second, title: 'sample', user: factory_administrator, label_ids: [second_label.id]) }

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = FactoryBot.build(:testtask, title: '', user: factory_administrator, label_ids: [label.id])
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = FactoryBot.build(:testtask, content: '', user: factory_administrator, label_ids: [label.id])
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = FactoryBot.build(:testtask, title: '成功テスト', content: '成功テスト', user: factory_administrator, label_ids: [label.id])
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
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
    context 'scopeメソッドでラベル検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_label(second_label.id)).to include(second_task)
        expect(Task.search_label(second_label.id)).not_to include(task)
        expect(Task.search_label(second_label.id).count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索とラベル検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスとラベルに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('sample').search_status(0).search_label(second_label.id)).to include(second_task)
        expect(Task.search_title('sample').search_status(0).search_label(second_label.id)).not_to include(task)
        expect(Task.search_title('sample').search_status(0).search_label(second_label.id).count).to eq 1
      end
    end
  end
end
