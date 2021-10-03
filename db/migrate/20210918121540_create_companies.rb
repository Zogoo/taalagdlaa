class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :logo
      t.integer :rating
      t.string :description
      t.string :owner_name
      t.string :phone_number
      t.string :industry
      t.date :established_at

      t.timestamps
    end
  end
end
