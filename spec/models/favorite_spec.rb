require 'rails_helper'

RSpec.describe Favorite do
  describe "#total_count" do
    it "can calculate total number of favorites" do
      favorite = Favorite.new([1, 2, 3, 4])

      expect(favorite.total_count).to eq(4)
    end
  end

  describe "#add_pet" do
    it "adds pets to favorites contents" do
      favorite = Favorite.new([])
      favorite.add_pet(1)
      favorite.add_pet(2)

      expect(favorite.contents).to eq([1, 2])
    end
  end
end
