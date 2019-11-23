class CreateTalks < ActiveRecord::Migration[5.2]
  def change
    create_table :talks do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :receive_user, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
