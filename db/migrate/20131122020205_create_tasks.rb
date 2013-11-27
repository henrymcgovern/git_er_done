class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :description
      t.boolean :do
      t.boolean :done
      t.integer :category_id
      t.belongs_to :user

      t.timestamps
    end
  end
end
