class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user, index: true, foreign_key: true
      t.datetime :report_date
      t.string :progress
      t.string :achievement
      t.string :next_day_plan
      t.string :comment_question

      t.timestamps null: false
    end
    add_index :reports, [:user_id, :created_at]
  end
end
