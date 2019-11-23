class RemoveRoomFromTalk < ActiveRecord::Migration[5.2]
  def change
    remove_reference :talks, :room, foreign_key: true
  end
end
