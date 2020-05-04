class CreateRatingCaches < ActiveRecord::Migration[5.2]

  def self.up
      create_table :rating_caches do |t|
        t.belongs_to :cacheable, :polymorphic => true
        t.float :avg, :null => false
        t.integer :qty, :null => false
        t.string :dimension
        t.timestamps
      end
    end

    def self.down
      drop_table :rating_caches
    end

end