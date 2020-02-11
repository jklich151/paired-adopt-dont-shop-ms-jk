require 'rails_helper'

RSpec.describe "Pet Applications Index Page" do
  it "can see a message that there are no applications when there are no applications" do
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

    click_link "All Applications"

    expect(current_path).to eq("/pets/#{pet_1.id}/applications")
    expect(page).to have_content("There are no applications for this pet.")
  end
end
