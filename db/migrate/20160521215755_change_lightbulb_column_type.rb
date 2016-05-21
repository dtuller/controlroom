class ChangeLightbulbColumnType < ActiveRecord::Migration
  def change
    change_column :lightbulbs, :control_id,  :string
  end
end
