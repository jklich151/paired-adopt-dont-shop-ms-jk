require "rails_helper"

RSpec.describe "shelters show page", type: :feature do
  context "as a visitor" do
    it "can see a link to each shelter review to edit them" do
      shelter_2 = Shelter.create(name: "Meg's Shelter",
                                 address: '150 Main Street',
                                 city: 'Hershey',
                                 state: 'PA',
                                 zip: '17033')
      review_1 = shelter_2.reviews.create(title: "Review for Mike's",
                                          rating: 4,
                                          content: "This shelter was great, and very helpful. They sent us home with a bag of free food!")
      review_2 = shelter_2.reviews.create(title: "Review for Meg's",
                                          rating: 5,
                                          content: "Love this Shelter",
                                          picture: "https://image.shutterstock.com/image-photo/bowl-dry-kibble-dog-food-600w-416636413.jpg")

      visit "/shelters/#{shelter_2.id}"

      within "#review-#{review_1.id}" do
        have_link "Update Review"
      end

      within "#review-#{review_2.id}" do
        click_link "Update Review"
      end
      expect(current_path).to eq "/shelters/#{shelter_2.id}/reviews/#{review_2.id}/edit"

      expect(find_field('title').value).to eq "Review for Meg's"
      expect(find_field('rating').value).to eq "5"
      expect(find_field('content').value).to eq "Love this Shelter"
      expect(find_field('picture').value).to eq "#{review_2.picture}"

      fill_in 'title', with: 'Wonderful'
      fill_in 'content', with: 'Love this Shelter. I highly recommend this shelter over any!'

      click_on "Save changes"
      expect(current_path).to eq("/shelters/#{shelter_2.id}")
      expect(page).to have_content("Review: Wonderful")
      expect(page).to have_content("Comment: Love this Shelter. I highly recommend this shelter over any!")
    end
  end

  it "can see error message if required fields not filled in" do
    shelter_2 = Shelter.create(name: "Meg's Shelter",
                               address: '150 Main Street',
                               city: 'Hershey',
                               state: 'PA',
                               zip: '17033')
    review_1 = shelter_2.reviews.create(title: "Review for Mike's",
                                        rating: 4,
                                        content: "This shelter was great, and very helpful. They sent us home with a bag of free food!")
    review_2 = shelter_2.reviews.create(title: "Review for Meg's",
                                        rating: 5,
                                        content: "Love this Shelter",
                                        picture: "https://image.shutterstock.com/image-photo/bowl-dry-kibble-dog-food-600w-416636413.jpg")

    visit "/shelters/#{shelter_2.id}"

    within "#review-#{review_2.id}" do
      click_link "Update Review"
    end
    expect(current_path).to eq "/shelters/#{shelter_2.id}/reviews/#{review_2.id}/edit"

    fill_in 'rating', with: 4
    fill_in 'content', with: "Highly recommend"

    click_on "Save changes"
    expect(current_path).to eq("/shelters/#{shelter_2.id}/reviews/#{review_2.id}/edit")
    expect(page).to have_content("You have not filled in one of these required fields: Title, Rating, Content")
  end
end
