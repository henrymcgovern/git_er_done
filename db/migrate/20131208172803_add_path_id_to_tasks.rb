class AddPathIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :path_id, :integer
  end
end
