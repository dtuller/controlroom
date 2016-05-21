class AddRoomIdToLightbulbs < ActiveRecord::Migration
  def change
    add_column :lightbulbs, :room_id, :integer
  end
end
