class Tag < ApplicationRecord
  has_many :tag_relations
  has_many :recipes, though: :tag_relations
  
  validates :name, presence: true
end
