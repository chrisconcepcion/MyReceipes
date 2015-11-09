class Review < ActiveRecord::Base
  validates :body, presence: true 
  belongs_to :chef
  belongs_to :recipe
end