class AddMetricsColumnsToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :satisfaction_rating, :integer
    add_column :notes, :difficulty, :integer
  end
end
