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
    expect(page).to have_content("Favorites: 0")
  end

  it "can click button next to pet to remove pet" do
    shelter_1 = Shelter.create(name: "Mike's Shelter",
                               address: '1331 17th Street',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80202')
    pet_1 = shelter_1.pets.create(image: "https://i0.wp.com/cdn-prod.medicalnewstoday.com/content/images/articles/322/322868/golden-retriever-puppy.jpg?w=1155&h=1541",
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

    visit "/pets/#{pet_2.id}"
    click_button "Add To Favorites"

    visit "/favorites"

    within "#pet-#{pet_1.id}" do
      click_button "Remove From Favorites"
    end
    expect(current_path).to eq("/favorites")
    expect(page).to_not have_css("img[src*='#{pet_1.image}']")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content("Favorites: 1")
  end

  it "can remove all favorited pets at once" do
    shelter_1 = Shelter.create(name: "Mike's Shelter",
                               address: '1331 17th Street',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80202')
    pet_1 = shelter_1.pets.create(image: "https://i0.wp.com/cdn-prod.medicalnewstoday.com/content/images/articles/322/322868/golden-retriever-puppy.jpg?w=1155&h=1541",
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

    visit "/pets/#{pet_2.id}"
    click_button "Add To Favorites"

    expect(page).to have_content("Favorites: 2")

    visit "/favorites"
    click_link "Remove all Favorites"
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("You no longer have any favorites.")
    expect(page).to have_content("Favorites: 0")
  end

  it "can see a message that favorites is empty when no favorites have been added." do

    visit "/favorites"

    expect(page).to have_content("You have no pets in your favorites.")
    expect(page).to have_content("Favorites: 0")
  end

  it "can see a list of pets that have been applied for" do
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

    visit "/pets/#{pet_2.id}"
    click_button "Add To Favorites"

    visit "/favorites"
    click_link "Adopt Pets"

    within "#pet-#{pet_1.id}" do
      check :adopt_pets_
    end

    fill_in 'name', with: "Bob"
    fill_in 'address', with: "4567 Larimer"
    fill_in 'city', with: "Denver"
    fill_in 'state', with: "CO"
    fill_in 'zip', with: "80202"
    fill_in 'phone_number', with: "7204706332"
    fill_in 'description', with: "I want this dog."

    click_button "Submit Application"
    expect(page).to have_content("Your application has been submitted!")

    expect(page).to have_content("Pets that have been applied for:")
    expect(page).to have_link(pet_1.name)
  end
end
