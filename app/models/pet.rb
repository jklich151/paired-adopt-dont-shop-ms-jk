class Pet < ApplicationRecord
  validates_presence_of :image, :name, :age, :sex, :description, :status, :shelter_id
  belongs_to :shelter
end
