class SheltersController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def new

  end

  def create
    shelter = Shelter.new({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      })

    shelter.save
    if !shelter.save
      flash[:notice] = shelter.errors.full_messages.to_sentence
      redirect_to "/shelters/new"
    else
      redirect_to '/shelters'
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update ({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      })

      shelter.save
      if shelter.save
        redirect_to "/shelters/#{shelter.id}"
      else
        flash[:notice] = shelter.errors.full_messages.to_sentence
        redirect_to "/shelters/#{shelter.id}/edit"
      end
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end
end
