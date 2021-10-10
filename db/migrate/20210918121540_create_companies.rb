class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.references :category, null: true
      t.string :name, default: nil
      t.string :label, default: ''
      t.string :logo
      t.integer :rating, default: 0
      t.integer :price_range, default: 0
      t.string :phone_number
      t.string :web_url, default: ''
      t.string :description, default: ''
      t.string :address, default: ''
      t.json :open_hours
      t.string :owner_name
      t.json :industry
      t.date :established_at
      t.jsonb :tags, default: {}

      t.timestamps
    end

    add_index :companies, :name, unique: true
  end
end
