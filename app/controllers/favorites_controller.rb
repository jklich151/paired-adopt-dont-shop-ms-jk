class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorites] = favorite.contents
    if session[:favorites].include?(pet.id)
      flash[:notice] = "You now have added #{pet.name} to your favorites."
      redirect_to "/pets/#{pet.id}"
    else
      flash[:notice] = "#{pet.name} has been removed from favorites."
      redirect_to "/pets/#{pet.id}"
    end
  end

  def index
    @pets = Pet.find(session[:favorites])
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorite.contents.delete(pet.id)
    redirect_to "/pets/#{pet.id}"
  end
end
