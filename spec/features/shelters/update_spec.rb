require 'rails_helper'

RSpec.describe "Shelters edit page" do
  it "can see an error if required fields are not filled in" do
    shelter_1 = Shelter.create(name: "Mike's Shelter",
                               address: '1331 17th Street',
                               city: 'Denver',
                               state: 'CO',
                               zip: '80202')
    visit "/shelters"

    within "#shelter-#{shelter_1.id}" do
      click_link "Update Shelter"
    end

    fill_in "name", with: ""

    click_on "Save changes"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
    expect(page).to have_content("Name can't be blank")
  end
end
