class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients
  has_many :cook_steps
  has_many :comments
  has_many :tags
  has_many :tag_relations
  has_many :favorites

  validates :user_id, precedence: true
  validates :name, precedence: true, length: { maximum: 50 }
  validates :introduction, precedence: true, length: { maximum: 140 }

  validates :require_any_ingredients
  validates :require_any_cook_steps

  def require_any_ingredients
    errors.add(:base, "食材は１つ以上登録してください。") if self.ingredients.blank?
  end

  def require_any_cook_steps
    errors.add(:base, "作り方は１つ以上登録してください。") if self.cook_steps.blank?
  end
end
