# t.string :name
# t.integer :rating
# t.string :description
# t.string :owner_name
# t.date   :established_at
# t.string :phone_number
# t.string :industry
# t.date :established_at
class Company < ApplicationRecord
  mount_uploader :logo, ImageUploader
  has_many :reviews
  belongs_to :category, optional: true
end
