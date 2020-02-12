require 'rails_helper'

RSpec.describe "Pets edit page" do
  it "see a message if all fields are not filled in" do
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

    visit "/shelters/#{shelter_1.id}/pets"

    click_link "Update Pet"

    fill_in "image", with: "https://cdn.sanity.io/images/0vv8moc6/dvm360/81e9bbc1fe445afd4c888497d6e8e4d8abcd9029-450x274.jpg"
    fill_in "name", with: "Fluffy"
    fill_in "description", with: "Fluffy"
    fill_in "age", with: "1"
    fill_in "sex", with: ""

    click_on "Save changes"

    expect(current_path).to eq("/pets/#{pet.id}/edit")
    expect(page).to have_content("Sex can't be blank")
  end
end
