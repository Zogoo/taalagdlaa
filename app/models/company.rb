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
  before_create :convert_name

  enum status: %i[active hidden suspended deleted]

  scope :by_tags, lambda { |tags|
    where('tags @> ?', tags.to_json)
  }

  scope :by_name, lambda { |name|
    where('name LIKE :name', name: "%#{Regexp.escape(name.to_s.downcase.strip)}%")
  }

  def convert_name
    self.name = name.to_s.downcase
  end
end
