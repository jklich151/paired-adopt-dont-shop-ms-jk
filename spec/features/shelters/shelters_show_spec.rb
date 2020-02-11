require 'rails_helper'

# User story 3
RSpec.describe "shelters show id page", type: :feature do
  context 'as a visitor' do
    it "can see one shelter's information" do
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

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content("Shelter ID: #{shelter_1.id}")
      expect(page).to have_content("Shelter: #{shelter_1.name}")
      expect(page).to have_content("Address: #{shelter_1.address}")
      expect(page).to have_content("City: #{shelter_1.city}")
      expect(page).to have_content("State: #{shelter_1.state}")
      expect(page).to have_content("Zipcode: #{shelter_1.zip}")
    end
  end
end

# User story 5
RSpec.describe "shelters show id page", type: :feature do
  context "as a visitor" do
    it "can update a shelter" do
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

      visit "/shelters/#{shelter_1.id}"

      click_on "Update Shelter"
      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

      fill_in 'zip', with: "80234"

      click_on "Save changes"
      expect(page).to have_content("Mike's Shelter")
      expect(page).to have_content("Zipcode: 80234")
    end
  end
end

# USer story 6
RSpec.describe "shelters show id page", type: :feature do
  context "as a visitor" do
    it "can delete a shelter" do
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

      visit "/shelters/#{shelter_1.id}"

      click_on "Delete"
      expect(current_path).to eq("/shelters")
      expect(page).to have_content("Meg's Shelter")
      expect(page).to have_no_content("Mike's Shelter")
    end
  end

  it "can see shelter statistics" do
    shelter_1 = Shelter.create!(name: "Meg's Shelter",
                               address: '150 Main Street',
                               city: 'Hershey',
                               state: 'PA',
                               zip: '17033')
    pet_1 = shelter_1.pets.create!(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                      name: "Ozzie",
                      age: "6",
                      sex: "Male",
                      description: "Very cuddly",
                      status: "adoptable")
    pet_2 = shelter_1.pets.create!(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                      name: "Harley",
                      age: "2",
                      sex: "Male",
                      description: "Playful",
                      status: "adoptable")
    pet_3 = shelter_1.pets.create!(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                      name: "Odell",
                      age: "5",
                      sex: "Male",
                      description: "Playful",
                      status: "adoptable")
    review_1 = shelter_1.reviews.create(title: "Review for Mike's",
                                        rating: 4,
                                        content: "This shelter was great, and very helpful. They sent us home with a bag of free food!",
                                        picture: "https://image.shutterstock.com/image-photo/bowl-dry-kibble-dog-food-600w-416636413.jpg")

    review_2 = shelter_1.reviews.create(title: "Review for Meg's",
                                        rating: 5,
                                        content: "Love this Shelter")
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
    app_pet_1 = pet_1.application_pets.create!(application: app_1, pet: pet_1)
    app_pet_2 = pet_2.application_pets.create!(application: app_2, pet: pet_2)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Total Pets: 3")
    expect(page).to have_content("Average Rating: 4.5")
    expect(page).to have_content("Number of Pet Applications: 2")
  end
end
