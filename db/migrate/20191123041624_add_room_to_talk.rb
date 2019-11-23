class AddRoomToTalk < ActiveRecord::Migration[5.2]
  def change
    add_reference :talks, :room, foreign_key: true
  end
end
