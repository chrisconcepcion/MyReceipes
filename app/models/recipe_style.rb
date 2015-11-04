class RecipeStyle < ActiveRecord::Base
  validates :recipe_id, presence: true
  validates :style_id, presence: true
  belongs_to :recipe
  belongs_to :style
end