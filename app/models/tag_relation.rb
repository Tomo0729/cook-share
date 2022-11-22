class TagRelation < ApplicationRecord
  belongs_to :recipe
  belongs_to :tag_relations

  validates :recipe_id, presence: true
  validates :tag_id, presence: true
end
