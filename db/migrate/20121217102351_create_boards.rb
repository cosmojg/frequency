class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :id
      t.string :title, limit: 50

      t.timestamps
    end
  end
end
