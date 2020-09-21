class ChangeColumnNulToTasksStatus < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :status, :integer, null: false, default: 0
  end
end
