class CreateSceneLightbulbStates < ActiveRecord::Migration
  def change
    create_table :scene_lightbulb_states do |t|
      t.integer :scene_id
      t.integer :state_id
      t.integer :lightbulb_id

      t.timestamps

    end
  end
end
