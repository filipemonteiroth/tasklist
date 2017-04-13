class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.boolean :completed, default: false
      t.timestamp :completed_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
