class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id
      t.integer :visited_id
      t.integer :recipe_id
      t.integer :recipe_review_id

      t.timestamps
    end
  end
end
