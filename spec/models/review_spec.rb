require "rails_helper"

RSpec.describe Review, type: :model do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :content}
    it {should validate_presence_of :rating}
  end

  describe "relationships" do
    it {should belong_to :shelter}
  end

  describe "#average_rating" do
    it "can calculate average rating from reviews" do
      shelter_1 = Shelter.create!(name: "Meg's Shelter",
                                 address: '150 Main Street',
                                 city: 'Hershey',
                                 state: 'PA',
                                 zip: '17033')
      review_1 = shelter_1.reviews.create(title: "Review for Mike's",
                                         rating: 4,
                                         content: "This shelter was great, and very helpful. They sent us home with a bag of free food!")
      review_2 = shelter_1.reviews.create(title: "Review for Meg's",
                                         rating: 5,
                                         content: "Love this Shelter",
                                         picture: "https://image.shutterstock.com/image-photo/bowl-dry-kibble-dog-food-600w-416636413.jpg")

      reviews = shelter_1.reviews
      
      expect(reviews.average_rating).to eq(4.5)
    end
  end
end
