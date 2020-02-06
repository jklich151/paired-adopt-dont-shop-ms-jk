require 'rails_helper'

RSpec.describe "favorites index page" do
  it "can view all favorited pets" do
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
    pet_3 = shelter_1.pets.create(image: "https://www.perfectdogbreeds.com/wp-content/uploads/2019/03/Pitbull-Dog.jpg",
                        name: "Odell",
                        age: "4",
                        sex: "Male",
                        description: "sassy",
                        status: "available")
    visit "/pets/#{pet_1.id}"

    click_button "Add To Favorites"


    visit "/pets/#{pet_2.id}"

    click_button "Add To Favorites"

    visit "/favorites"

    expect(page).to have_content("Ozzie")
    expect(page).to have_content("Harley")
    expect(page).to_not have_content("Odell")

    click_link "Favorites:"

    expect(current_path).to eq("/favorites")
  end

  it "can only favorite a pet once" do
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

    visit "/pets/#{pet_1.id}"

    click_button "Add To Favorites"

    expect(page).to_not have_button("Add To Favorites")
    expect(page).to have_button("Remove From Favorites")

    click_button "Remove From Favorites"

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("#{pet_1.name} has been removed from favorites.")
    expect(page).to have_button("Add To Favorites")
    expect(page).to have_content("Favorite: 0")
  end
end
