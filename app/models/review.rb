class Review < ActiveRecord::Base
  validates :comment, :presence => true
  validates :comment, length: { minimum: 2 }
  belongs_to :user
  belongs_to :product
end
