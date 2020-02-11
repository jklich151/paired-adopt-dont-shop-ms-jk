class Pet < ApplicationRecord
  validates_presence_of :image, :name, :age, :sex, :description, :status, :shelter_id
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def self.with_applications
    Pet.joins(:application_pets)
  end

  def self.with_approved_apps
    Pet.where("status = 'pending'")
  end
end
