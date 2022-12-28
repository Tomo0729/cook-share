class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 100 }
end
