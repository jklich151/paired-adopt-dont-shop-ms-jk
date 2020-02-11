require 'rails_helper'

# User story 9
RSpec.describe "pets show page", type: :feature do
  context 'as a visitor' do
    it "can see pet information" do
      shelter_1 = Shelter.create(name: "Mike's Shelter",
                                 address: '1331 17th Street',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip: '80202')
      shelter_2 = Shelter.create(name: "Meg's Shelter",
                                 address: '150 Main Street',
                                 city: 'Hershey',
                                 state: 'PA',
                                 zip: '17033')
      pet_1 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                                     name: "Ozzie",
                                     age: "6",
                                     sex: "Male",
                                     description: "playful",
                                     status: "adoptable")
      pet_2 = shelter_2.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                                     name: "Harley",
                                     age: "2",
                                     sex: "Male",
                                     description: "good dog",
                                     status: "pending")


      visit "/pets"

      click_link "Ozzie"
      expect(current_path).to eq("/pets/#{pet_1.id}")

      expect(page).to have_content("#{pet_1.name}")
      expect(page).to have_content("Pet ID: #{pet_1.id}")
      expect(page).to have_css("img[src*='#{pet_1.image}']")
      expect(page).to have_content("Description: #{pet_1.description}")
      expect(page).to have_content("Age: #{pet_1.age}")
      expect(page).to have_content("Sex: #{pet_1.sex}")
      expect(page).to have_content("Status: #{pet_1.status}")
    end
  end
end

# User story 11
RSpec.describe "pets show page", type: :feature do
  context 'as a visitor' do
    it "can update a pet" do
      shelter_1 = Shelter.create(name: "Mike's Shelter",
                                 address: '1331 17th Street',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip: '80202')
      shelter_2 = Shelter.create(name: "Meg's Shelter",
                                 address: '150 Main Street',
                                 city: 'Hershey',
                                 state: 'PA',
                                 zip: '17033')
      pet_1 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                                     name: "Ozzie",
                                     age: "6",
                                     sex: "Male",
                                     description: "playful",
                                     status: "adoptable")
      pet_2 = shelter_2.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                                     name: "Harley",
                                     age: "2",
                                     sex: "Male",
                                     description: "good dog",
                                     status: "pending")


      visit "/pets/#{pet_1.id}"

      click_link "Update Pet"
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      fill_in 'age', with: "7"
      fill_in 'description', with: "lazy"

      click_on "Save changes"
      expect(current_path).to eq("/pets/#{pet_1.id}")
      expect(page).to have_content("Age: 7")
      expect(page).to have_content("Description: lazy")
    end
  end
end

# User story 12
RSpec.describe "shelters show page", type: :feature do
  context "as a visitor" do
    it "can delete a pet" do
      shelter_1 = Shelter.create(name: "Mike's Shelter",
                                 address: '1331 17th Street',
                                 city: 'Denver',
                                 state: 'CO',
                                 zip: '80202')
      shelter_2 = Shelter.create(name: "Meg's Shelter",
                                 address: '150 Main Street',
                                 city: 'Hershey',
                                 state: 'PA',
                                 zip: '17033')
      pet_1 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                                     name: "Ozzie",
                                     age: "6",
                                     sex: "Male",
                                     description: "playful",
                                     status: "adoptable")
      pet_2 = shelter_2.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                                     name: "Harley",
                                     age: "2",
                                     sex: "Male",
                                     description: "good dog",
                                     status: "pending")
      pet_3 = shelter_2.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                                     name: "Duece",
                                     age: "4",
                                     sex: "Female",
                                     description: "old",
                                     status: "pending")

      visit "/pets/#{pet_1.id}"

      click_on "Delete Pet"
      expect(current_path).to eq("/pets")

      expect(current_path).to have_no_content(pet_3.image)
      expect(current_path).to have_no_content(pet_3.name)
      expect(current_path).to have_no_content(pet_3.age)
      expect(current_path).to have_no_content(pet_3.sex)
    end
  end

  it "can click link to view all applicant names for one pet" do
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
    app_1 = Application.create(name: "Meg",
                                    address: "1234 Turing Lane",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80202",
                                    phone_number: "7204706332",
                                    description: "I want this dog")
    application_pet_1 = pet_1.application_pets.create!(application: app_1, pet: pet_1)
    app_2 = Application.create(name: "Mike",
                                    address: "1234 Turing Lane",
                                    city: "Denver",
                                    state: "CO",
                                    zip: "80202",
                                    phone_number: "7204706332",
                                    description: "I want this dog")
    application_pet_2 = pet_1.application_pets.create!(application: app_2, pet: pet_1)

    visit "/pets/#{pet_1.id}"

    click_link "All Applications"

    expect(current_path).to eq("/pets/#{pet_1.id}/applications")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_css("img[src*='#{pet_1.image}']")
    expect(page).to have_link(app_1.name)
    expect(page).to have_link(app_2.name)

    click_link "#{app_1.name}"

    expect(current_path).to eq("/applications/#{app_1.id}")
  end

  it "can't delete a pet with an approved application" do
    shelter_1 = Shelter.create(name: "Mike's Shelter",
                               address: '1331 17th Street',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80202')
    pet_1 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                     name: "Ozzie",
                     age: "6",
                     sex: "Male",
                     description: "Good boy",
                     status: "pending")
    pet_2 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                     name: "Harley",
                     age: "2",
                     sex: "Female",
                     description: "puppy",
                     status: "adoptable")

    visit "/pets/#{pet_1.id}"

    expect(page).to_not have_button("Delete Pet")
  end

  it "is removed from favorites if deleted" do
    shelter_1 = Shelter.create(name: "Mike's Shelter",
                               address: '1331 17th Street',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80202')
    pet_1 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                     name: "Ozzie",
                     age: "6",
                     sex: "Male",
                     description: "Good boy",
                     status: "adoptable")
    pet_2 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                     name: "Harley",
                     age: "2",
                     sex: "Male",
                     description: "Good boy",
                     status: "adoptable")

    visit "/pets/#{pet_1.id}"
    click_on "Add To Favorites"

    visit "/pets"

    within "#pet-#{pet_1.id}" do
      click_on "Delete Pet"
    end

    visit "/favorites"
    expect(page).to_not have_content(pet_1.name)
  end
end
