require "rails_helper"

RSpec.describe "shelters show page", type: :feature do
  context "as a visitor" do
    it "can see all reviews for that shelter" do
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
      review_1 = shelter_1.reviews.create(title: "Review for Mike's",
                                          rating: 4,
                                          content: "This shelter was great, and very helpful. They sent us home with a bag of free food!",
                                          picture: "https://image.shutterstock.com/image-photo/bowl-dry-kibble-dog-food-600w-416636413.jpg")

      review_2 = shelter_2.reviews.create(title: "Review for Meg's",
                                          rating: 5,
                                          content: "Love this Shelter")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content("Review: #{review_1.title}")
      expect(page).to have_content("Rating: #{review_1.rating}")
      expect(page).to have_content("Comment: #{review_1.content}")
      expect(page).to have_css("img[src*='#{review_1.picture}']")

      visit "/shelters/#{shelter_2.id}"

      expect(page).to have_content("Review: #{review_2.title}")
      expect(page).to have_content("Rating: #{review_2.rating}")
      expect(page).to have_content("Comment: #{review_2.content}")
      expect(page).to have_css("img[src*='#{review_2.picture}']")
    end
  end

  it "can create a new review for the shelter" do
    shelter_2 = Shelter.create(name: "Meg's Shelter",
                               address: '150 Main Street',
                               city: 'Hershey',
                               state: 'PA',
                               zip: '17033')

    visit "/shelters/#{shelter_2.id}"

    click_link "New Review"
    expect(current_path).to eq "/shelters/#{shelter_2.id}/reviews/new"

    fill_in "Title", with: "Great experience"
    fill_in "Rating", with: 5
    fill_in "Content", with: "Overall great experience, helped us find the right dog for our family."
    fill_in "Picture", with: ""

    click_on "Add Review"
    new_review = Review.last

    expect(current_path).to eq "/shelters/#{shelter_2.id}"

    expect(page).to have_content("Review: #{new_review.title}")
    expect(page).to have_content("Rating: #{new_review.rating}")
    expect(page).to have_content("Comment: #{new_review.content}")
    expect(page).to have_css("img[src*='#{new_review.picture}']")
  end

end
