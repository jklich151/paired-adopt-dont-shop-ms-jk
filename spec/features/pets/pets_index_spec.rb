require 'rails_helper'

# User story 7
RSpec.describe "pets index page", type: :feature do
  context "as a visitor" do
    it "can see all pets" do
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
      pet = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                        name: "Ozzie",
                        age: "6",
                        sex: "Male",
                        description: "Good boy",
                        status: "pending")

      visit '/pets'

      expect(page).to have_content("Name: #{pet.name}")
      expect(page).to have_css("img[src*='#{pet.image}']")
      expect(page).to have_content("#{pet.age}")
      expect(page).to have_content("#{pet.sex}")
      expect(page).to have_content("Shelter: #{pet.shelter.name}")
    end
  end
end

RSpec.describe "pets index page", method: :feature do
  context "as a visitor" do
    it "can edit any pet" do
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
                        description: "Good boy",
                        status: "pending")
      pet_2 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                        name: "Harley",
                        age: "2",
                        sex: "Female",
                        description: "puppy",
                        status: "adoptable")

      visit '/pets'

      within "#pet-#{pet_1.id}" do
        click_link "Update Pet"
      end
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")
    end
  end
end

# User story 16
RSpec.describe "pets index page", method: :feature do
  context "as a visitor" do
    it "can delete any pet" do
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
                        description: "Good boy",
                        status: "adoptable")
      pet_2 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                        name: "Harley",
                        age: "2",
                        sex: "Female",
                        description: "puppy",
                        status: "adoptable")

      visit '/pets'

      within "#pet-#{pet_1.id}" do
        click_on "Delete Pet"
      end
      expect(current_path).to eq("/pets")
    end
  end
end

# User story 17
RSpec.describe "pets index page", method: :feature do
  context "as a visitor" do
    it "can click on the name of s helter and be directed to the it's show page" do
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
                        description: "Good boy",
                        status: "pending")
      pet_2 = shelter_1.pets.create(image: "https://image.shutterstock.com/image-photo/happy-golden-retriever-dog-sitting-600w-1518698711.jpg",
                        name: "Harley",
                        age: "2",
                        sex: "Female",
                        description: "puppy",
                        status: "adoptable")

      visit '/pets'

      within "#pet-#{pet_1.id}" do
        click_link "#{shelter_1.name}"
      end
      expect(current_path).to eq("/shelters/#{shelter_1.id}")
    end
  end

  it "can't delet a pet with an approved application" do
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

    visit "/pets"

    within "#pet-#{pet_1.id}" do
      expect(page).to_not have_button("Delete Pet")
    end
  end
end
