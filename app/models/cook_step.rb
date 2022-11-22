class CookStep < ApplicationRecord
  belongs_to :recipe

  validates :direction, presence: true
end
