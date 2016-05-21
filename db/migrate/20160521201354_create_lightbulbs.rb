class CreateLightbulbs < ActiveRecord::Migration
  def change
    create_table :lightbulbs do |t|
      t.integer :user_id
      t.integer :state_id
      t.integer :control_id
      t.string :name

      t.timestamps

    end
  end
end
