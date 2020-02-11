require "rails_helper"

RSpec.describe "application show page" do
  it "can see the application info and names of pets" do
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
    app = Application.create(name: "Meg",
                                    address: "1234 Turing Lane",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80202",
                                    phone_number: "7204706332",
                                    description: "I want this dog")
    application_pet = pet_1.application_pets.create!(application: app, pet: pet_1)

    visit "/applications/#{app.id}"

    expect(page).to have_content(app.name)
    expect(page).to have_content(app.address)
    expect(page).to have_content(app.city)
    expect(page).to have_content(app.state)
    expect(page).to have_content(app.zip)
    expect(page).to have_content(app.phone_number)
    expect(page).to have_content(app.description)
    expect(page).to have_content(pet_1.name)
    expect(page).to_not have_content(pet_2.name)
  end

  it "can approve an application" do
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
    app = Application.create(name: "Meg",
                                    address: "1234 Turing Lane",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80202",
                                    phone_number: "7204706332",
                                    description: "I want this dog")
    application_pet = pet_1.application_pets.create!(application: app, pet: pet_1)
    application_pet = pet_2.application_pets.create!(application: app, pet: pet_2)

    visit "/applications/#{app.id}"

    within "#application-#{pet_1.id}" do
      click_link "Approve Application"
    end

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("Status: pending")
    expect(page).to have_content("On hold for #{app.name}")
  end

  it "can approve applications for many pets" do
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
                                  status: "adoptable")
    visit "/pets/#{pet_1.id}"
    click_button "Add To Favorites"
    visit "/pets/#{pet_2.id}"
    click_button "Add To Favorites"
    expect(page).to have_content("Favorites: 2")

    visit "/favorites"
    click_link "Adopt Pets"
    expect(current_path).to eq("/applications/new")

    within "#pet-#{pet_1.id}" do
      check :adopt_pets_
    end
    within "#pet-#{pet_2.id}" do
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
    app = Application.last

    visit "/applications/#{app.id}"
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    within "#application-#{pet_1.id}" do
      click_link "Approve Application"
    end
    expect(page).to have_content("Status: pending")

    visit "/applications/#{app.id}"

    expect(page).to have_content(pet_2.name)
    within "#application-#{pet_2.id}" do
      click_link "Approve Application"
    end
    expect(page).to have_content("Status: pending")
  end

  it "cant approve more than one application" do
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
    app_1 = Application.create(name: "Meg",
                                    address: "1234 Turing Lane",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80202",
                                    phone_number: "7204706332",
                                    description: "I want this dog")
    app_2 = Application.create(name: "Mike",
                                    address: "1234 Turing Lane",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80202",
                                    phone_number: "7204706332",
                                    description: "I want this dog")

    app_pet = pet_1.application_pets.create!(application: app_1, pet: pet_1)
    app_pet = pet_1.application_pets.create!(application: app_2, pet: pet_1)

    visit "/applications/#{app_1.id}"

    within "#application-#{pet_1.id}" do
      click_link "Approve Application"
    end

    visit "/applications/#{app_2.id}"
    within "#application-#{pet_1.id}" do
      expect(page).to_not have_link("Approve Application")
    end
  end
end
