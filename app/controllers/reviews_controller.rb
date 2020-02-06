class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    review = shelter.reviews.create(review_params)
    if review.save
    redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Review not created: Required information missing."

      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  def destroy
    shelter = Shelter.find(params[:shelter_id])
    Review.destroy(params[:id])
    redirect_to "/shelters/#{shelter.id}"
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :picture)
    end
end
