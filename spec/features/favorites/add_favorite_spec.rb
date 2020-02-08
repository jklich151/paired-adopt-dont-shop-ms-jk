require 'rails_helper'

RSpec.describe "When a user adds pets to their favorites" do
  it "displays a message" do
    shelter_1 = Shelter.create(name: "Mike's Shelter",
                               address: '1331 17th Street',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80202')
    pet = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                               name: "Ozzie",
                               age: "6",
                               sex: "Male",
                               description: "Good boy",
                               status: "pending")
    visit "/pets/#{pet.id}"

      click_button "Add To Favorites"

    expect(page).to have_content("You now have added #{pet.name} to your favorites.")
  end

  it "the message correctly increments for multiple songs" do
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

    visit "/pets/#{pet_1.id}"

    click_button "Add To Favorites"

    expect(page).to have_content("Favorites: 1")

    visit "/pets/#{pet_2.id}"

    click_button "Add To Favorites"

    expect(page).to have_content("Favorites: 2")
  end
end
