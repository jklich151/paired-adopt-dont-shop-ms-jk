require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :image}
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :description}
    it {should validate_presence_of :status}
  end

  describe "relationships" do
    it {should belong_to :shelter}
    it {should have_many :application_pets}
    it {should have_many(:applications).through(:application_pets)}
  end

  describe "#with_applications" do
    it "can return array of pets that have been applied for" do
      shelter_1 = Shelter.create(name: "Mike's Shelter",
                                 address: '1331 17th Street',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip: '80202')
      pet_1 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                                    name: "Ozzie",
                                    age: "6",
                                    sex: "Male",
                                    description: "playful",
                                    status: "adoptable")
      pet_2 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                                    name: "Harley",
                                    age: "2",
                                    sex: "Male",
                                    description: "good dog",
                                    status: "pending")
      application = Application.create(name: "Meg",
                                      address: "1234 Turing Lane",
                                      city: "Denver",
                                      state: "CO",
                                      zip: "80202",
                                      phone_number: "7204706332",
                                      description: "I want this dog")

      application_pet = pet_1.application_pets.create!(application: application, pet: pet_1)

      pets = Pet.all

      expect(pets.with_applications).to eq([pet_1])
    end
  end

  describe "#with_approved_apps" do
    it "can return array of pets with approved apps" do
      shelter_1 = Shelter.create(name: "Mike's Shelter",
                                 address: '1331 17th Street',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip: '80202')
      pet_1 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                                    name: "Ozzie",
                                    age: "6",
                                    sex: "Male",
                                    description: "playful",
                                    status: "adoptable")
      pet_2 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                                    name: "Harley",
                                    age: "2",
                                    sex: "Male",
                                    description: "good dog",
                                    status: "pending")
      application = Application.create(name: "Meg",
                                      address: "1234 Turing Lane",
                                      city: "Denver",
                                      state: "CO",
                                      zip: "80202",
                                      phone_number: "7204706332",
                                      description: "I want this dog")

      application_pet = pet_2.application_pets.create!(application: application, pet: pet_2)

      pets = Pet.all

      expect(pets.with_approved_apps).to eq([pet_2])
    end
  end
end
