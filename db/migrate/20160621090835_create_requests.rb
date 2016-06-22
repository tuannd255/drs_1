class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :kind_of_leave
      t.time :time_out
      t.time :time_in
      t.time :time
      t.time :compensation_time

      t.timestamps null: false
    end
  end
end
