class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :label_name, null: false, default: "unlabeled"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
