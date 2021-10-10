class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.references :review
      t.string :image

      t.timestamps
    end
  end
end
