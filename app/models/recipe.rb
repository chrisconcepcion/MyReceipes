class Recipe < ActiveRecord::Base
  belongs_to :chef
  has_many :likes
  has_many :recipe_styles
  has_many :styles, through: :recipe_styles
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  validates :name, presence: true, length: { in: 5..99 }
  validates :summary, presence: true, length: { in: 10..149 }
  validates :description, presence: true, length: { in: 20..499 }
  validates :chef_id, presence: true
  mount_uploader :picture, PictureUploader
  default_scope -> { order(updated_at: :desc) } 
  
  def thumbs_up_total
    self.likes.where(like: true).size
  end
  
  def thumbs_down_total
    self.likes.where(like: false).size
  end
  
  
  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end