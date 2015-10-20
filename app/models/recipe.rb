class Recipe < ActiveRecord::Base
  belongs_to :chef
  validates :name, presence: true, length: { in: 5..99 }
  validates :summary, presence: true, length: { in: 10..149 }
  validates :description, presence: true, length: { in: 20..499 }
  validates :chef_id, presence: true
end