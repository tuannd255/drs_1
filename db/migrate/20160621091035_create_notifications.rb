class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :receiver
      t.string :status
      t.string :content

      t.timestamps null: false
    end
  end
end
