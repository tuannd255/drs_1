class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :request, index: true, foreign_key: true
      t.boolean :seen, default: false

      t.timestamps null: false
    end
  end
end
