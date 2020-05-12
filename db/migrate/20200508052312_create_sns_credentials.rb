class CreateSnsCredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :sns_credentials do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
