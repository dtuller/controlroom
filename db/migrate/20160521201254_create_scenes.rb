class CreateScenes < ActiveRecord::Migration
  def change
    create_table :scenes do |t|
      t.integer :user_id
      t.string :name

      t.timestamps

    end
  end
end
