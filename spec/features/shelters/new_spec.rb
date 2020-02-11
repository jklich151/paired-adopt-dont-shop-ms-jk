require 'rails_helper'

RSpec.describe "Shelters new page" do
  it "can see a message for missing fields when creating a new sheklter" do

    visit "/shelters"

    click_link "New Shelter"

    fill_in "name", with: "Puppy Place"
    fill_in "address", with: "123 Puppy Street"
    fill_in "city", with: "Denver"
    fill_in "state", with: "CO"
    fill_in "zip", with: ""

    click_on "Create Shelter"

    expect(current_path).to eq("/shelters/new")
    expect(page).to have_content("Zip can't be blank")
  end
end
