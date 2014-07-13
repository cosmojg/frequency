class CreateThrottles < ActiveRecord::Migration
  def change
    create_table :throttles do |t|
      t.integer :user_id
      t.string :model

      t.timestamps
    end

    add_index :throttles, [:user_id, :model], unique: true
  end
end
