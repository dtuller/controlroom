class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.integer :user_id
      t.string :effect
      t.string :alert
      t.integer :blue
      t.integer :green
      t.integer :red
      t.integer :brightness
      t.boolean :on
      t.string :name

      t.timestamps

    end
  end
end
