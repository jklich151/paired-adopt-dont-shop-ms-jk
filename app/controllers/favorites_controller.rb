class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorites] = favorite.contents
    flash[:notice] = "You now have added #{pet.name} to your favorites."

    redirect_to "/pets/#{pet.id}"
  end

  def index
    if session[:favorites] == nil || session[:favorites].empty?
      @pets = nil
    else
      @pets = Pet.all
    end
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    session[:favorites].delete(pet.id)
    flash[:notice] = "#{pet.name} has been removed from favorites."

    redirect_back(fallback_location: "/favorites")
  end

  def destroy_all
    session[:favorites] = {}
    flash[:notice] = "You no longer have any favorites."

    redirect_to '/favorites'
  end
end
