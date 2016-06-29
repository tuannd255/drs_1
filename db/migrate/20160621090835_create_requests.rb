class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :kind_of_leave
      t.datetime :time_out
      t.datetime :time_in
      t.time :time
      t.string :compensation_time
      t.string :reason
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :requests, [:user_id, :created_at]
  end
end
