class ChangeColumnDefaultToLabels < ActiveRecord::Migration[5.2]
  def change
    change_column_default :labels, :label_name, from: "unlabeled", to: ""
  end
end
