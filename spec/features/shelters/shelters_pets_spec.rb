require 'rails_helper'

# User story 8
RSpec.describe "shelters id pets page", type: :feature do
  context "as a visitor" do
    it "can see all Pets for that shelter and the shelter id" do
      shelter_1 = Shelter.create!(name: "Mike's Shelter",
                                 address: '1331 17th Street',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip: '80202')
      shelter_2 = Shelter.create!(name: "Meg's Shelter",
                                 address: '150 Main Street',
                                 city: 'Hershey',
                                 state: 'PA',
                                 zip: '17033')
      pet_1 = shelter_1.pets.create!(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                        name: "Ozzie",
                        age: "6",
                        sex: "Male",
                        description: "Very cuddly",
                        status: "pending")
      pet_2 = shelter_2.pets.create!(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                        name: "Harley",
                        age: "2",
                        sex: "Male",
                        description: "Playful",
                        status: "adoptable")

      visit "/shelters/#{shelter_1.id}"

      click_link "Pets"
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_content("#{shelter_1.name}'s Pets")
      expect(page).to have_content("Shelter ID: #{shelter_1.id}")
      expect(page).to have_css("img[src*='#{pet_1.image}']")
      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("#{pet_1.age}")
      expect(page).to have_content("#{pet_1.sex}")
    end
  end
end

# User story 10
RSpec.describe "shelters id pets page", type: :feature do
  context "as a visitor" do
    it "can see a link 'Create Pet' to add a new pet" do
      shelter_1 = Shelter.create!(name: "Mike's Shelter",
                                 address: '1331 17th Street',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip: '80202')
      shelter_2 = Shelter.create!(name: "Meg's Shelter",
                                 address: '150 Main Street',
                                 city: 'Hershey',
                                 state: 'PA',
                                 zip: '17033')
      pet_1 = shelter_1.pets.create!(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                        name: "Ozzie",
                        age: "6",
                        sex: "Male",
                        description: "Very cuddly",
                        status: "pending")
      pet_2 = shelter_2.pets.create!(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                        name: "Harley",
                        age: "2",
                        sex: "Male",
                        description: "Playful",
                        status: "adoptable")

      visit "/shelters/#{shelter_1.id}/pets"

      click_link "Create Pet"
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

      expect(page).to have_content("New Pet info")
      expect(page).to have_content("Link to Image")
      expect(page).to have_content("Name:")
      expect(page).to have_content("Description")
      expect(page).to have_content("Age:")
      expect(page).to have_content("Sex:")
      expect(page).to have_content("Status:")

      fill_in 'image', with: "https://image.shutterstock.com/image-photo/dog-jack-russell-terrier-on-600w-1510303826.jpg"
      fill_in 'name', with: "Duece"
      fill_in 'description', with: "Boxer runt"
      fill_in 'age', with: "8"
      fill_in 'sex', with: "Male"
      fill_in 'status', with: "pending"

      click_button "Create Pet"
      new_pet = Pet.last

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
      expect(page).to have_css("img[src*='#{new_pet.image}']")
      expect(page).to have_content("Age: #{new_pet.age}")
      expect(page).to have_content("Sex: #{new_pet.sex}")
      expect(page).to have_content("#{shelter_1.name}")
    end
  end
end
