class RemoveColumnsFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :deadline, :datetime
    remove_column :tasks, :priority, :integer
    remove_column :tasks, :status, :integer
  end
end
