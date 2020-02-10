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
end
