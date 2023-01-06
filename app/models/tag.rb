class Tag < ApplicationRecord
  has_many :tag_relations, dependent: :destroy
  has_many :recipes, through: :tag_relations

  validates :name, presence: true
end
