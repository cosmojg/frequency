class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer :id
      t.string :title
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
