class Review < ActiveRecord::Base
  belongs_to :product

  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true, length: { minimum: 1 }
  validates :rating, presence: true, numericality: { only_integer: true, less_than: 6, greater_than: 0 }
end
