class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter.reviews.create(review_params)

    redirect_to "/shelters/#{shelter.id}"
  end

  def edit
    @review = Review.find(params[:review_id])
    @shelter_id = params[:shelter_id]
  end

  def update
    @review = Review.find(params[:review_id])
    @review.update(review_params)

    if @review.save
      redirect_to "/shelters/#{@review.shelter.id}"
    else
      flash[:notice] = "You have not filled in one of these required fields: Title, Rating, Content"
      redirect_to "/shelters/#{@review.shelter.id}/reviews/#{@review.id}/edit"
    end
  end

  private
    def review_params
      params.permit(:title, :rating, :content, :picture)
    end
end
