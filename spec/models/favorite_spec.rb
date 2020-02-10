require 'rails_helper'

RSpec.describe Favorite do
  describe "#total_count" do
    it "can calculate total number of favorites" do
      favorite = Favorite.new([1, 2, 3, 4])

      expect(favorite.total_count).to eq(4)
    end
  end

  describe "#add_pet" do
    it "adds pets to favorites contents" do
      favorite = Favorite.new([])
      favorite.add_pet(1)
      favorite.add_pet(2)

      expect(favorite.contents).to eq([1, 2])
    end
  end

  describe "#pets" do
    it "can return array with favorited pets" do
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
      favorite = Favorite.new([])
      favorite.add_pet(pet_1.id)
      favorite.add_pet(pet_2.id)

      expect(favorite.pets).to eq([pet_1, pet_2])
    end
  end
end
