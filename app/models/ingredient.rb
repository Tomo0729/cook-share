class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true
  validates :quantity, presence: true

  def self.search(search)
    if search
      Ingredient.where('name LIKE (?), "%#{search}%')
    else
      Recipe.all
    end
  end
end
