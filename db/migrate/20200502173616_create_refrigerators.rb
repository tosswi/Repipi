class CreateRefrigerators < ActiveRecord::Migration[5.2]
  def change
    create_table :refrigerators do |t|
      t.string :name
      t.integer :quantity

      t.timestamps
    end
  end
end
