class Recipe < ActiveRecord::Base
  belongs_to :chef
  validates :name, presence: true, length: { in: 5..99 }
  validates :summary, presence: true, length: { in: 10..149 }
  validates :description, presence: true, length: { in: 20..499 }
  validates :chef_id, presence: true
  mount_uploader :picture, PictureUploader
  
  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end