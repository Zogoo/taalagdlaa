class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :rating
      t.string :description
      t.string :owner_name
      t.date :established_at

      t.timestamps
    end
  end
end
