class Photo < ApplicationRecord
  belongs_to :review
  mount_uploader :photo, ImageUploader
end
