class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.integer :point
      t.integer :reason
      t.integer :user_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
