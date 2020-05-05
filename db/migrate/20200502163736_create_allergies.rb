class CreateAllergies < ActiveRecord::Migration[5.2]
  def change
    create_table :allergies do |t|
      t.integer :allergy

      t.timestamps
    end
  end 
end
