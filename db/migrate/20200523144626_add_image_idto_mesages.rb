class AddImageIdtoMesages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :image_id, :string
  end
end
