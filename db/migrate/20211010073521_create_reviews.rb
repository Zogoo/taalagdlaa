class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :company
      t.integer :status, default: 0

      # Main fields
      t.string :comment, default: ''
      t.integer :ratings, default: 0, null: false

      # Customers feedback for comment
      t.integer :votes, default: 0, null: false
      t.integer :spam, default: 0, null: false

      # Rating
      t.integer :service_rating, default: 0, null: false
      t.integer :access_rating, default: 0, null: false
      t.integer :comfort_rating, default: 0, null: false
      t.jsonb :specific_ratings, default: {}

      # Mention
      t.jsonb :tag, default: {}

      t.timestamps
    end
  end
end
