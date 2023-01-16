class CookStep < ApplicationRecord
  belongs_to :recipe
  has_one_attached :image

  validates :direction, presence: true

end
