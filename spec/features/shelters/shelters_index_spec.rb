require 'rails_helper'

# User story 2
RSpec.describe "shelters index page", type: :feature do
  context 'as a visitor' do
    it "can see all shelter names" do
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

      visit '/shelters'

      expect(page).to have_content("All Shelters")
      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
    end
  end
end

# User story 4
RSpec.describe "shelters index page", type: :feature do
  context 'as a visitor' do
    it "can click New Shelter, create new shelter, and sent back to shelters index" do
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

      visit "/shelters"
      click_link "New Shelter"
      expect(current_path).to eq("/shelters/new")

      expect(page).to have_content("Name:")
      expect(page).to have_content("Address:")
      expect(page).to have_content("City:")
      expect(page).to have_content("State:")
      expect(page).to have_content("Zipcode")
      expect(page).to have_content("New Shelter info")

      fill_in 'name', with: "Pets4Paws"
      fill_in 'address', with: "1234 Petco Street"
      fill_in 'city', with: "Broomfield"
      fill_in 'state', with: "CO"
      fill_in 'zip', with: "80020"

      click_on "Create Shelter"

      expect(page).to have_content("Pets4Paws")
    end
  end
end

# User story 13
RSpec.describe "shelters index page", type: :feature do
  context "as a visitor" do
    it "can see link next to each shelter to update" do
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

      visit "/shelters"

      within "#shelter-#{shelter_1.id}" do
        click_link "Update Shelter"
      end
      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

      fill_in 'state', with: 'CO'
      fill_in 'zip', with: '80020'

      click_on "Save changes"
      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("State: CO")
      expect(page).to have_content("Zipcode: 80020")
    end
  end
end

# User story 14
RSpec.describe "shelters index page", method: :feature do
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
      pet_1 = shelter_1.pets.create(image: "https://i0.wp.com/cdn-prod.medicalnewstoday.com/content/images/articles/322/322868/golden-retriever-puppy.jpg?w=1155&h=1541",
                                  name: "Ozzie",
                                  age: "6",
                                  sex: "Male",
                                  description: "playful",
                                 status: "adoptable")

      visit "/shelters"

      within "#shelter-#{shelter_1.id}" do
        click_on "Delete Shelter"
      end
      expect(current_path).to eq("/shelters")
    end
  end

  it "cannot be deleted with current approved applicatons" do
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
    visit '/shelters'

    within "#shelter-#{shelter_1.id}" do
      expect(page).to_not have_button("Delete Shelter")
    end

    visit "/shelters/#{shelter_1.id}"

    expect(page).to_not have_button("Delete")
  end

  it "can delete all reviews when shelter is deleted" do
    shelter_1 = Shelter.create(name: "Mike's Shelter",
                               address: '1331 17th Street',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80202')
    review_1 = shelter_1.reviews.create(title: "Review for Mike's",
                                       rating: 4,
                                       content: "This shelter was great, and very helpful. They sent us home with a bag of free food!",
                                       picture: "https://image.shutterstock.com/image-photo/bowl-dry-kibble-dog-food-600w-416636413.jpg")

    visit "/shelters"

    within "#shelter-#{shelter_1.id}" do
      expect { click_button "Delete Shelter" }.to change(Shelter && Review, :count).by(-1)
    end
  end
end
