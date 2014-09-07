class Idea < ActiveRecord::Base
  validates_numericality_of :grade, greater_than: 0, less_than_or_equal_to: 10
  validates_numericality_of :min_partners, greater_than_or_equal_to: 0

  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user
end
