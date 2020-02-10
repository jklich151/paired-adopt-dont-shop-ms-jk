require "rails_helper"

RSpec.describe "favorites index page" do
  it "can apply for adoption for favorited pets" do
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
    click_link "Adopt Pets"
    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Application Form")
    expect(page).to have_content("Please select who you would like to adopt today!")

    within "#pet-#{pet_1.id}" do
      check :adopt_pets_
    end

    fill_in 'name', with: "Meg"
    fill_in 'address', with: "1234 Turing Lane"
    fill_in 'city', with: "Denver"
    fill_in 'state', with: "CO"
    fill_in 'zip', with: "80202"
    fill_in 'phone_number', with: "7204706332"
    fill_in 'description', with: "I love dogs."

    click_button "Submit Application"
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Your application has been submitted!")
  end

  it "can't submit adoption form unless all fields are filled out" do
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

    visit "/favorites"
    click_link "Adopt Pets"

    within "#pet-#{pet_1.id}" do
      check :adopt_pets_
    end

    fill_in 'name', with: "Bob"
    fill_in 'address', with: "4567 Larimer"
    fill_in 'city', with: "Denver"
    fill_in 'zip', with: "80202"
    fill_in 'phone_number', with: ""
    fill_in 'description', with: ""

    click_button "Submit Application"
    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Form not submitted: Required information missing.")

    fill_in 'name', with: "Bob"
    fill_in 'address', with: "4567 Larimer"
    fill_in 'city', with: "Denver"
    fill_in 'zip', with: "80202"
    fill_in 'phone_number', with: "7204706332"
    fill_in 'description', with: "Love this dog."
    click_button "Submit Application"

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Form not submitted: Required information missing.")
  end
end
