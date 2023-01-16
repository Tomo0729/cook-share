class Recipe < ApplicationRecord

  has_one_attached :image
  
  belongs_to :user
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  has_many :cook_steps, dependent: :destroy
  accepts_nested_attributes_for :cook_steps, allow_destroy: true

  has_many :comments, dependent: :destroy

  has_many :tag_relations, dependent: :destroy
  accepts_nested_attributes_for :tag_relations, allow_destroy: true
  
  has_many :tags, through: :tag_relations

  has_many :favorites, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :introduction, presence: true, length: { maximum: 140 }

  #validates :user_id, precedence: true

  #validates :require_any_ingredients
  #validates :require_any_cook_steps
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def require_any_ingredients
    errors.add(:base, "食材は１つ以上登録してください。") if self.ingredients.blank?
  end

  def require_any_cook_steps
    errors.add(:base, "作り方は１つ以上登録してください。") if self.cook_steps.blank?
  end


  def self.search(keyword)
    if keyword
     Recipe.where(['name LIKE (?)', "%#{keyword}%"])
    else
     Recipe.all
    end
  end
end
