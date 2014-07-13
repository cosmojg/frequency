class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :id
      t.integer :activity_creator_id
      t.string :activity_creator_type
      t.integer :user_id

      t.timestamps
    end
  end
end
