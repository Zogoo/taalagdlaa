class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :company
      t.string :comment
      t.integer :rate

      t.timestamps
    end
  end
end
