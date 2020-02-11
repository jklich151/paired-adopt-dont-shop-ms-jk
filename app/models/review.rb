class Review < ApplicationRecord
  validates_presence_of :title, :content, :rating
  belongs_to :shelter

  def self.average_rating
    average(:rating)
  end
end
