class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id, null: false
      t.integer :visited_id, null: false
      t.integer :talk_id
      t.integer :comment_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
    
    add_index :notifications, :visiter_id
    add_index :notifications, :visited_id
    add_index :notifications, :talk_id
    add_index :notifications, :comment_id
    
  end
end
