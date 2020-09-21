class ChangeNulToTasks < ActiveRecord::Migration[5.2]
  def up
    change_column_null :tasks, :status, false
  end

  def down
    change_column_null :tasks, :status, true
  end
end
