class AddIndexToTaskLabels < ActiveRecord::Migration[5.2]
  def change
    add_index :task_labels, :task_id
    add_index :task_labels, :label_id
  end
end
