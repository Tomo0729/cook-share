class Comment < ApplicationRecord
  belongs_to :recipe
  belongs_to :users

  validates :comment, presence: true, length: { maximum: 100 }
end
